From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 3 Sep 2015 10:10:44 +0100
Subject: [PATCH] ARM: fix bug which VMALLOC_START is lowwer than
 0xf0000000
In-Reply-To: <1441269809-11688-1-git-send-email-ytk.lee@samsung.com>
References: <1441269272.3102.3.camel@pengutronix.de>
 <1441269809-11688-1-git-send-email-ytk.lee@samsung.com>
Message-ID: <20150903091044.GW21084@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 03, 2015 at 05:43:29PM +0900, Yongtaek Lee wrote:
> > So, if we go and apply your logic to a 1GB system we should resize the
> > vmalloc area to 0 bytes in order to avoid RAM truncation without
> > CONFIG_HIGHMEM?
> 
> As you already know, CONFIG_HIGHMEM option is necessary if RAM is
> more than 1GB. So no need to resize vmalloc area to 0. 

Wrong, there is no such "rule".

If we apply that rule, then if you have 1GB of RAM, it will fill from
0xc0000000 to 0xffffffff inclusive.  There will be _zero_ bytes of
vmalloc space.  There will be _zero_ bytes of IO mappings.  There won't
even be a vectors page, so the kernel _will_ crash on the first exception.
The "rule" you think exists doesn't because it is wrong.

-- 
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
