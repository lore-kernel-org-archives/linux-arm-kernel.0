From: leif.lindholm@linaro.org (Leif Lindholm)
Date: Tue, 8 Sep 2015 17:55:24 +0100
Subject: [RFC 5/5] HACK: serial: move pl011 initcall to device_initcall
In-Reply-To: <20150908125608.GD20562@leverpostej>
References: <1441716217-23786-1-git-send-email-leif.lindholm@linaro.org>
 <1441716217-23786-6-git-send-email-leif.lindholm@linaro.org>
 <20150908125608.GD20562@leverpostej>
Message-ID: <20150908165524.GO10728@bivouac.eciton.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 08, 2015 at 01:56:08PM +0100, Mark Rutland wrote:
> On Tue, Sep 08, 2015 at 01:43:37PM +0100, Leif Lindholm wrote:
> > ---
> >  drivers/tty/serial/amba-pl011.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/tty/serial/amba-pl011.c b/drivers/tty/serial/amba-pl011.c
> > index 452dbba..31cf985 100644
> > --- a/drivers/tty/serial/amba-pl011.c
> > +++ b/drivers/tty/serial/amba-pl011.c
> > @@ -2806,7 +2806,7 @@ static void __exit pl011_exit(void)
> >   * While this can be a module, if builtin it's most likely the console
> >   * So let's leave module_exit but move module_init to an earlier place
> >   */
> > -arch_initcall(pl011_init);
> > +device_initcall(pl011_init);
> >  module_exit(pl011_exit);
> 
> What's the ordering constraint that you're trying to solve with this?

Basically that _CRS is not available until the ACPI subsystem is up -
so when uart_add_one_port() calls acpi_console_check(), that function
looks for a match against variables that have not been set yet.

> The cover didn't mention anything, and there's no commit message.

That's because I really don't want it committed :)
 
> Mark.
> 
> >  
> >  MODULE_AUTHOR("ARM Ltd/Deep Blue Solutions Ltd");
> > -- 
> > 2.1.4
> > 
