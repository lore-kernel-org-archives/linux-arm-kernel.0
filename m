From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 2 Jun 2015 11:54:07 +0100
Subject: [PATCH V2 1/1] ARM: dts: imx7d: add cortex-a7 coresight component
In-Reply-To: <1433237208.6844.22.camel@mm-sol.com>
References: <1433192081-1131-1-git-send-email-Frank.Li@freescale.com>
 <1433237208.6844.22.camel@mm-sol.com>
Message-ID: <20150602105407.GB2067@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 02, 2015 at 12:26:48PM +0300, Ivan T. Ivanov wrote:
> 
> Hi, 
> 
> On Tue, 2015-06-02 at 04:54 +0800, Frank.Li at freescale.com wrote:
> > 
> > +
> > +???????etm at 3007d000 {
> > +               compatible = "arm,coresight-etm3x", "arm,primecell";
> > +               reg = <0x3007d000 0x1000>;
> > +
> > +               /* System will hang if added nosmp in kernel command line
> > +                       * without arm,primecell-periphid because amba bus try to
> > +                       * read id and core1 power off at this time.
> > +                       */
> > +               arm,primecell-periphid =  <0xbb956>;
> 
> I do have similar problem, but in my case it is APB clock which is
> missing during device creation time. And I don't know how to fix it.
> 
> Adding Russell King as he's the maintainer of the arm,primecell bus.

If it was possible to postpone reading the ID until probe time, then
that's how I'd suggest to fix this problem, but unfortunately it isn't.
We need to know the device's ID by the time the bus ->match function
is called.

The problem with the match function is that it has two possible
return values: 0 and non-0 meaning "doesn't match" and "does match".
There's no possibility of returning -EPROBE_DEFER here.

So, if we don't have the ID when we're trying to match drivers to the
devices, our only option is to say "doesn't match" which effectively
means it'll never automatically match its driver.

Short of modifying the driver core (which isn't going to be popular)
I don't see an easy solution to this problem.

For Frank's problem, this looks to me like something that PM domains
should be used for - but I guess it runs into the issue that PM domains
aren't up at the time we try to bring secondary CPUs online - and
brings with it a whole host of issues surrounding the time that
resources (PM domains and therefore clocks) are available.

Maybe what we need there is some way of representing the PM domains,
one where drivers can be attached to a PM domain and enquire at load
time whether it's powered up.

-- 
FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.
