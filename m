From: marek.vasut@gmail.com (Marek Vasut)
Date: Thu, 8 Jul 2010 18:42:16 +0200
Subject: linux 2.6.34 bug
In-Reply-To: <20100708173621.00003527@unknown>
References: <20100708173621.00003527@unknown>
Message-ID: <201007081842.16347.marek.vasut@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dne ?t 8. ?ervence 2010 17:36:21 dylan cristiani napsal(a):
> Hi Marek,
> we were in touch few moths ago about a ucb1400 touchscreen, issue if you
> remember: you sent me a patch to pass the platform specific codec irq,
> through ucb1400_pdata; after that i went from 3.6.32 to 2.6.34 and
> i noticed that your patch was into mainline; in this kernel, related to
> the ucb1400 codec again, i noticed one bug about the ac97 codec reset
> that is bulverde platform specific: i don't know hot to submit a patch
> and to whom to submit it, so i bother, you sorry in advance....; in
> particular: in new kernel the function
> "void pxa27x_assert_ac97reset(int reset_gpio, int on)"
> has been moved to arch/arm/mach-pxa/pxa27x.c file:

CCing linux-arm-kernel and Eric.

btw. to submit patch :

git add <list of changed files>

git commit -s
<editor will pop up, type the commit message>

git log # here check the hash of the last commit before yours

git send-email --to="linux-arm-kernel at lists.infradead.org" --
cc="eric.y.miao at gmail.com" --cc="marek.vasut at gmail.com" <the hash from previous 
step>

That's probably the easiest way :)
> 
> ......
> static unsigned long ac97_reset_config[] = {
> 	GPIO95_AC97_nRESET,
> 	GPIO95_GPIO,
> 	GPIO113_AC97_nRESET,
> 	GPIO113_GPIO,
> };
> 
> void pxa27x_assert_ac97reset(int reset_gpio, int on)
> {
> 	if (reset_gpio == 113)
> 		pxa2xx_mfp_config(on ? &ac97_reset_config[0] :
> 				       &ac97_reset_config[1], 1);
> 
> 	if (reset_gpio == 95)
> 		pxa2xx_mfp_config(on ? &ac97_reset_config[2] :
> 				       &ac97_reset_config[3], 1);
> }
> EXPORT_SYMBOL_GPL(pxa27x_assert_ac97reset);
> .......
> 
> but, as it seems to me, there are two bugs: the first is the cross
> exchange of the position of the
> 	'if (reset_gpio == 113)'
> with position of
> 	'if (reset_gpio == 95)'
> with regard to the position of the members of the array
> "static unsigned long ac97_reset_config[]"

Seems like a good catch, Eric ?
> 
> The 2nd one regards the "pxa2xx_mfp_config(..)" function's call at
> sound/arm/pxa2xx-ac97-lib.c line 340:
> 
> 	if (cpu_is_pxa27x()) {
> 		/* Use GPIO 113 as AC97 Reset on Bulverde */
> 		pxa27x_assert_ac97reset(reset_gpio, 0);
> 		ac97conf_clk = clk_get(&dev->dev, "AC97CONFCLK");
> 		.....
> 
> so, if the second param is 0, (as the comment /**/ states) you want to
> use gpio 113 as AC97 reset (that is the Alternative Function 2 of the
> pin), so the function call into arch/arm/mach-pxa/pxa27x.c has to be:
> 
> 	if (reset_gpio == 113)
> 		pxa2xx_mfp_config(on ? &ac97_reset_config[3] :
> 				       &ac97_reset_config[2], 1);
> 
> instead the current:
> 
> 	if (reset_gpio == 113)
> 		pxa2xx_mfp_config(on ? &ac97_reset_config[2] :
> 				       &ac97_reset_config[3], 1);
> 
> i noticed that you can solve the whole bugs just moving the array
> members of "ac97_reset_config[]" into this:
> 
> static unsigned long ac97_reset_config[] = {
> 	GPIO113_GPIO,
> 	GPIO113_AC97_nRESET,
> 	GPIO95_GPIO,
> 	GPIO95_AC97_nRESET,
> };
> 
> i tryed this and for me it works; i'm sorry again to bother you but i
> don't really know how to submit a bug report so maybe you can do this
> if it sounds good to your expert ears
> 
> tks and sorry for the noise and don't hate me if i wrote some
> garbage stuff...

Eric, care to explain? I see a valid point here.
Thanks
