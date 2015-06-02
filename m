From: iivanov@mm-sol.com (Ivan T. Ivanov)
Date: Tue, 02 Jun 2015 15:15:47 +0300
Subject: [PATCH V2 1/1] ARM: dts: imx7d: add cortex-a7 coresight component
In-Reply-To: <20150602105407.GB2067@n2100.arm.linux.org.uk>
References: <1433192081-1131-1-git-send-email-Frank.Li@freescale.com>
 <1433237208.6844.22.camel@mm-sol.com>
 <20150602105407.GB2067@n2100.arm.linux.org.uk>
Message-ID: <1433247347.6844.25.camel@mm-sol.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


On Tue, 2015-06-02 at 11:54 +0100, Russell King - ARM Linux wrote:
> On Tue, Jun 02, 2015 at 12:26:48PM +0300, Ivan T. Ivanov wrote:
> > Hi,
> > 
> > On Tue, 2015-06-02 at 04:54 +0800, Frank.Li at freescale.com wrote:
> > > +
> > > +???????etm at 3007d000 {
> > > +               compatible = "arm,coresight-etm3x", "arm,primecell";
> > > +               reg = <0x3007d000 0x1000>;
> > > +
> > > +               /* System will hang if added nosmp in kernel command line
> > > +                       * without arm,primecell-periphid because amba bus try to
> > > +                       * read id and core1 power off at this time.
> > > +                       */
> > > +               arm,primecell-periphid =  <0xbb956>;
> > 
> > I do have similar problem, but in my case it is APB clock which is
> > missing during device creation time. And I don't know how to fix it.
> > 
> > Adding Russell King as he's the maintainer of the arm,primecell bus.
> 
> If it was possible to postpone reading the ID until probe time, then
> that's how I'd suggest to fix this problem, but unfortunately it isn't.
> We need to know the device's ID by the time the bus ->match function
> is called.

I have tried to read device ID again and again on every bus ->match until
succeed. with hope that driver which provide APB clock will be probed
in between, and this solve problem for me. But as Stephen Boyd point me,
this way uevent used for module auto loading will be broken. So no joy.

> Short of modifying the driver core (which isn't going to be popular)
> I don't see an easy solution to this problem.
> 

Thanks,
Ivan
