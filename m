From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 3 Sep 2015 09:00:28 +0100
Subject: [PATCH] ARM: fix bug which VMALLOC_START is lowwer than 0xf0000000
In-Reply-To: <1441247087-10342-1-git-send-email-ytk.lee@samsung.com>
References: <1441247087-10342-1-git-send-email-ytk.lee@samsung.com>
Message-ID: <20150903080028.GS21084@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 03, 2015 at 11:24:47AM +0900, Yongtaek Lee wrote:
> default value of vmalloc_min was set 0xf0000000 for ARM by commit
> 0536bdf3. But actually vmalloc_min is 0xef800000 not 0xf0000000.
> 
> VMALLOC_END - (240 << 20) - VMALLOC_OFFSET)
> 0xff000000 - 0x0f000000 - 0x00800000 = 0xef800000
> 
> In case of 768MB ram without CONFIG_HIGHMEM=y, last 8MB could not be
> allocated. Kernel log also print out warning message as below.
> "Truncating RAM at 80000000-afffffff to -af7fffff (vmalloc region overlap)."
> 
> Although it could be solved by state "vmalloc=size" in cmdline but i think
> it would be better to change default value to 232 from 240.
> 
> Signed-off-by: Yongtaek Lee <ytk.lee@samsung.com>

I fail to see what the problem is here.  You're adjusting the size of the
vmalloc space to accomodate the size of RAM you have.  That's not a bug.

-- 
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
