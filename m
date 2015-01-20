From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 20 Jan 2015 11:56:58 +0000
Subject: [PATCH v3 2/3] mfd: lubbock_io: add lubbock_io board
In-Reply-To: <20150120102919.GP5767@x1>
References: <1421406010-14851-1-git-send-email-robert.jarzmik@free.fr>
 <1421406010-14851-2-git-send-email-robert.jarzmik@free.fr>
 <20150119091705.GG21886@x1> <87ppaah9k5.fsf@free.fr>
 <20150120102919.GP5767@x1>
Message-ID: <20150120115658.GJ26493@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 20, 2015 at 10:29:19AM +0000, Lee Jones wrote:
> On Mon, 19 Jan 2015, Robert Jarzmik wrote:
> > >> +	if (ret) {
> > >> +		dev_err(&pdev->dev, "Couldn't request main irq : ret = %d\n",
> > >> +			ret);
> > >
> > > I'm not keen on this type of formatting.  Besides the system will
> > > print out the returned error on failure.
> > Well, it will print -EINVAL or -ENODEV. When I'll receive an request on the
> > driver with -ENODEV, how will I know it will come from this request_irq() or
> > another part of the code ... Well I can remove it if you want, but I think it's
> > an error.
> 
> I'm not asking you to remove the entire message, just the junk at the
> end.

No.  Leave it.  If request_irq() returns -ENODEV or -ENXIO, you'll
just get the "Couldn't request main irq" message but without the
error code printed.

What I'd suggest (and always have done) is:

	dev_err(&pdev->dev, "couldn't request main irq%d: %d\n",
		irq, ret);

but I guess printing the IRQ number no longer makes sense with todays
dynamic mapping of logical IRQ numbers, as it is no longer meaningful.

-- 
FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.
