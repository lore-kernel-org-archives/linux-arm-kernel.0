From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 7 Feb 2014 17:34:07 +0000
Subject: [PATCH RFC 1/2] drivers/base: permit base components to omit
 the bind/unbind ops
In-Reply-To: <9b3c3c2c982f31b026fd1516a2b608026d55b1e9.1391793068.git.moinejf@free.fr>
References: <cover.1391793068.git.moinejf@free.fr>
 <9b3c3c2c982f31b026fd1516a2b608026d55b1e9.1391793068.git.moinejf@free.fr>
Message-ID: <20140207173407.GE26684@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Feb 07, 2014 at 04:55:00PM +0100, Jean-Francois Moine wrote:
> Some simple components don't need to do any specific action on
> bind to / unbind from a master component.
> 
> This patch permits such components to omit the bind/unbind
> operations.
> 
> Signed-off-by: Jean-Francois Moine <moinejf@free.fr>
> ---
>  drivers/base/component.c | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/base/component.c b/drivers/base/component.c
> index c53efe6..0a39d7a 100644
> --- a/drivers/base/component.c
> +++ b/drivers/base/component.c
> @@ -225,7 +225,8 @@ static void component_unbind(struct component *component,
>  {
>  	WARN_ON(!component->bound);
>  
> -	component->ops->unbind(component->dev, master->dev, data);
> +	if (component->ops)
> +		component->ops->unbind(component->dev, master->dev, data);
>  	component->bound = false;
>  
>  	/* Release all resources claimed in the binding of this component */
> @@ -274,7 +275,11 @@ static int component_bind(struct component *component, struct master *master,
>  	dev_dbg(master->dev, "binding %s (ops %ps)\n",
>  		dev_name(component->dev), component->ops);
>  
> -	ret = component->ops->bind(component->dev, master->dev, data);
> +	if (component->ops)
> +		ret = component->ops->bind(component->dev, master->dev, data);
> +	else
> +		ret = 0;
> +

NAK.  If this is done, there's absolutely no point to this code.

-- 
FTTC broadband for 0.8mile line: 5.8Mbps down 500kbps up.  Estimation
in database were 13.1 to 19Mbit for a good line, about 7.5+ for a bad.
Estimate before purchase was "up to 13.2Mbit".
