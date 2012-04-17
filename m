From: viresh.kumar@st.com (Viresh Kumar)
Date: Tue, 17 Apr 2012 09:09:15 +0530
Subject: [PATCH] CLKDEV: Add helper routines to allocate and add clkdevs
 for given struct clk *
In-Reply-To: <20120416205133.GW3852@pengutronix.de>
References: <cfe2a4ef4a7903696200ca3880b96b4aa98c4820.1334553491.git.viresh.kumar@st.com>
 <20120416102503.GA32687@glitch> <4F8BF4DD.2080501@st.com>
 <20120416103822.GU24211@n2100.arm.linux.org.uk>
 <CAOh2x=kXeDOeZbAACOjKiwfdEniXkvAuFbrJ+rmgw=rq_gHQAg@mail.gmail.com>
 <20120416204609.GA8548@glitch> <20120416205133.GW3852@pengutronix.de>
Message-ID: <4F8CE5E3.9070304@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 4/17/2012 2:21 AM, s.hauer at pengutronix.de wrote:
>>> > > +struct clk_lookup * __init_refok
>>> > > +clkdev_alloc(struct clk *clk, const char *con_id, const char *dev_fmt, ...)
>>> > > +{
>>> > > +	struct clk_lookup * cl;
>>> > > +	va_list ap = NULL;

>> > so I finally tested it with this modification:
>> > 
>> > 	if (dev_fmt) {
>> > 		va_start(ap, dev_fmt);
>> > 		cl = clkdev_alloc_valist(clk, con_id, dev_fmt, ap);
>> > 		va_end(ap);
>> > 	} else
>> > 		cl = clkdev_alloc(clk, con_id, NULL);

> Same here. The correct fix is simply not to initialize ap.

As this will turn into an infinite loop, we can simple pass ap instead
of NULL in the earlier implementation. As clkdev_alloc_valist() always
checks dev_fmt before accessing ap, it will work fine.

-- 
viresh
