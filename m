From: pavel@ucw.cz (Pavel Machek)
Date: Fri, 26 Aug 2011 22:34:02 +0200
Subject: [PATCH] pcmcia/pxa2xx_sharpsl: retain ops structure on collie
In-Reply-To: <CAMPhdO-80Zd3uxTe8U-EKMooQUd6iucq05bxp2puMRrCtCbwVw@mail.gmail.com>
References: <1312715131-3956-1-git-send-email-dbaryshkov@gmail.com>
	<CALT56yPWBNgPONQfTCtN9rZLTWrXx53m3Dk-xx8XshPNwsrnqQ@mail.gmail.com>
	<CAMPhdO-80Zd3uxTe8U-EKMooQUd6iucq05bxp2puMRrCtCbwVw@mail.gmail.com>
Message-ID: <20110826203402.GB6697@ucw.cz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri 2011-08-19 10:19:33, Eric Miao wrote:
> On Thu, Aug 18, 2011 at 7:46 PM, Dmitry Eremin-Solenikov
> <dbaryshkov@gmail.com> wrote:
> > On Sun, Aug 7, 2011 at 3:05 PM, Dmitry Eremin-Solenikov
> > <dbaryshkov@gmail.com> wrote:
> >> The pxa2xx_sharpsl driver part is also used on collie, which (as
> >> a StrongARM board) has different expectations for PCMCIA drivers.
> >> So, on collie place sharpsl_pcmcia_ops in .data section rather than
> >> in __initdata.
> >>
> >> Signed-off-by: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
> >> Cc: stable at kernel.org
> >
> > Any comments on this patch?
> >
> >> diff --git a/drivers/pcmcia/pxa2xx_sharpsl.c b/drivers/pcmcia/pxa2xx_sharpsl.c
> >> index 69ae2fd..f2405dc 100644
> >> --- a/drivers/pcmcia/pxa2xx_sharpsl.c
> >> +++ b/drivers/pcmcia/pxa2xx_sharpsl.c
> >> @@ -219,7 +219,11 @@ static void sharpsl_pcmcia_socket_suspend(struct soc_pcmcia_socket *skt)
> >> ? ? ? ?sharpsl_pcmcia_init_reset(skt);
> >> ?}
> >>
> >> +#ifdef CONFIG_SA1100_COLLIE
> >> +static struct pcmcia_low_level sharpsl_pcmcia_ops = {
> >> +#else
> >> ?static struct pcmcia_low_level sharpsl_pcmcia_ops __initdata = {
> >> +#endif
> 
> Looks OK, and maybe we can put it even simpler by just removing __initdata.

I'd say so; ifdef to have  initdata there is just too ugly. But I
don't think it is stable material...
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
