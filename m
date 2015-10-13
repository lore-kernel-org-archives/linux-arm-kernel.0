From: lars@metafoo.de (Lars-Peter Clausen)
Date: Tue, 13 Oct 2015 15:44:09 +0200
Subject: [RFC PATCH] ASoC: Modify check condition of multiple bindings
 of components
In-Reply-To: <1444743477-48819-1-git-send-email-koro.chen@mediatek.com>
References: <1444743477-48819-1-git-send-email-koro.chen@mediatek.com>
Message-ID: <561D0AA9.5080702@metafoo.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/13/2015 03:37 PM, Koro Chen wrote:
> The patch "ASoC: Prevent components from being bound to multiple cards"
> adds check to prevent multiple cards from using the same component.
> However, snd_soc_register_platform() or snd_soc_register_codec() will
> also create components, and sharing the same platform by multiple cards
> is then refused. This happens with a platform having multiple
> independent DAIs that share the same DMA controller.
> 
> Relax the condition by checking component->registered_as_component,
> which is only true in case of snd_soc_register_component() and
> will be false for components created by snd_soc_register_platform()
> or snd_soc_register_codec().

Binding a component to multiple cards results in internal data structure
corruption, regardless of whether it is a raw component, CODEC or platform,
which is why the check was added. So the proposed change wont work.

> 
> Signed-off-by: Koro Chen <koro.chen@mediatek.com>
> ---
>  sound/soc/soc-core.c |    3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
> index 42575b0..eca169a 100644
> --- a/sound/soc/soc-core.c
> +++ b/sound/soc/soc-core.c
> @@ -1106,7 +1106,8 @@ static int soc_probe_component(struct snd_soc_card *card,
>  		return 0;
>  
>  	if (component->card) {
> -		if (component->card != card) {
> +		if (component->card != card &&
> +		    component->registered_as_component) {
>  			dev_err(component->dev,
>  				"Trying to bind component to card \"%s\" but is already bound to card \"%s\"\n",
>  				card->name, component->card->name);
> 
