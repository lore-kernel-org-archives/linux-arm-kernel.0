From: richardcochran@gmail.com (Richard Cochran)
Date: Sat, 26 Mar 2011 14:40:59 +0100
Subject: [PATCH V12 4/4] ptp: Added a clock driver for the National
	Semiconductor PHYTER.
In-Reply-To: <1300916785.848.54.camel@work-vm>
References: <cover.1298878618.git.richard.cochran@omicron.at>
	<f8af215ebe32a8c0f4b3a82b8ee7e8008b4feb1e.1298878618.git.richard.cochran@omicron.at>
	<1300916785.848.54.camel@work-vm>
Message-ID: <20110326134059.GC23260@riccoc20.at.omicron.at>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 23, 2011 at 02:46:25PM -0700, John Stultz wrote:
> On Mon, 2011-02-28 at 08:58 +0100, Richard Cochran wrote:
> > +static int tdr_write(int bc, struct phy_device *dev,
> > +		     const struct timespec *ts, u16 cmd)
> > +{
> > +	ext_write(bc, dev, PAGE4, PTP_TDR, ts->tv_nsec & 0xffff);/* ns[15:0]  */
> > +	ext_write(bc, dev, PAGE4, PTP_TDR, ts->tv_nsec >> 16);   /* ns[31:16] */
> > +	ext_write(bc, dev, PAGE4, PTP_TDR, ts->tv_sec & 0xffff); /* sec[15:0] */
> > +	ext_write(bc, dev, PAGE4, PTP_TDR, ts->tv_sec >> 16);    /* sec[31:16]*/
> > +
> > +	ext_write(bc, dev, PAGE4, PTP_CTL, cmd);
> > +
> > +	return 0;
> > +}
> 
> The above needs to hold the extreg_lock, and should be commented as
> such.

Okay, will do.

> And again, the function names are sort of generic, and could use a
> dp83640_ prefix or something.

So, I will rename the IXP functions in the other driver to make them
more unique, but in this case I really prefer to keep the short names
for the sake of readability.

Just about every operation on this PHY requires four 16-bit writes,
where each write can really mean two writes, with the first one to set
a "page" register for the following write.

Keeping the tabular style (shown above) makes it much more clear what
is going on, IMHO. If the function names become longer, that would
force line breaks and spoil the nice formatting.

Also, these names are not in use anywhere else in the kernel's eight
million LOC.

Thanks,

Richard
