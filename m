From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 28 Apr 2011 10:23:27 +0100
Subject: [PATCHv3 2.6.40 2/4] ARM: simpad: Cleanup CS3 accessors.
In-Reply-To: <1303377543-24794-3-git-send-email-jochen@scram.de>
References: <1303377543-24794-1-git-send-email-jochen@scram.de>
	<1303377543-24794-3-git-send-email-jochen@scram.de>
Message-ID: <20110428092327.GR17290@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 21, 2011 at 11:19:01AM +0200, Jochen Friedrich wrote:
> @@ -171,12 +226,13 @@ static void __init simpad_map_io(void)
>  
>  static void simpad_power_off(void)
>  {
> -	local_irq_disable(); // was cli
> -	set_cs3(0x800);        /* only SD_MEDIAQ */
> +	local_irq_disable(); /* was cli */

I think you can get rid of this comment - cli is ages old and I doubt
many people can remember that it was.

> @@ -47,15 +43,15 @@ simpad_pcmcia_socket_state(struct soc_pcmcia_socket *skt,
>  			   struct pcmcia_state *state)
>  {
>  	unsigned long levels = GPLR;
> -	long cs3reg = get_cs3_shadow();
> +	long cs3reg = simpad_get_cs3_shadow();
>  
>  	state->detect=((levels & GPIO_CF_CD)==0)?1:0;
>  	state->ready=(levels & GPIO_CF_IRQ)?1:0;
>  	state->bvd1=1; /* Not available on Simpad. */
>  	state->bvd2=1; /* Not available on Simpad. */
>  	state->wrprot=0; /* Not available on Simpad. */
> -  
> -	if((cs3reg & 0x0c) == 0x0c) {
> +
> +	if ((cs3reg & 0x0c) == 0x0c) {

Are there no definitions for the 0x0c magic value?
