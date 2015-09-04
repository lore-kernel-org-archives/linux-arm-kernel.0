From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Thu, 3 Sep 2015 21:24:00 -0400 (EDT)
Subject: [PATCH] ARM: fix bug which lowmem size is limited to 760MB
In-Reply-To: <1441276233-14566-1-git-send-email-ytk.lee@samsung.com>
References: <20150903091044.GW21084@n2100.arm.linux.org.uk>
 <1441276233-14566-1-git-send-email-ytk.lee@samsung.com>
Message-ID: <alpine.LFD.2.20.1509032106420.22877@knanqh.ubzr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 3 Sep 2015, Yongtaek Lee wrote:

> So i summarize my opinion again. 
> 
> Current status.
> 
> 768MB, no CONFIG_HIGHMEM and no vmalloc=size
> lowmem : 0MB ~ 760MB
> vmalloc : 768MB ~ VMALLOC_END
>   => waste 8MB because 760MB ~ 768MB is hole
> 
> 1GB, no CONFIG_HIGHMEM and no vmalloc=size
> lowmem : 0MB ~ 760MB
> vmalloc : 768MB ~ VMALLOC_END
>  => waste 264MB, so we need to enable CONFIG_HIGHMEM to use full memory. 
> highmem : 264MB if enable CONFIG_HIGHMEM 
> 
> after applying patch. 
> 
> 768MB, no CONFIG_HIGHMEM and no vmalloc=size
> lowmem : 0MB ~ 768MB
> vmalloc : 776MB ~ VMALLOC_END
>  => use 768MB fully
> 
> 1GB, no CONFIG_HIGHMEM and no vmalloc=size
> lowmem : 0MB ~ 768MB
> vmalloc : 776MB ~ VMALLOC_END
>  => waste 256MB, so we need to enable CONFIG_HIGHMEM to use full memory. 
> highmem : 256MB if enable CONFIG_HIGHMEM
>  => it will not fill from 0xc0000000 to 0xffffffff
> 
> My opinion is not that vmalloc area size should be changed for all cases(512M, 768M, 1GB, 2GB, etc.). 
> If we change default value from 240MB to 232MB, it could covor all cases without 
> any other changes so that i have suggested this patch. 
> 
> 
> As we already talked there are 3 cases with 768MB
> 1. live with the truncation => waste 8MB so that it will not be acceptable. 
> 2. enable CONFIG_HIGHMEM => mm point of view it could make overhead because there is only 8MB(very small) in highmem. 
> 3. set vmalloc size manually => I already mentioned it could fix issue but 
> if default value is suitable then it is needless.  

This is indeed unfortunate that the current value does not fit well with 
a 768MB configuration.  However this default value has been in place for 
many years now without problems on existing targets.  There is always a 
slight possibility that some targets might have issues with a reduced 
vmalloc size if we were to change it now.

If 768MB targets were common place then it could be worth changing the 
default vmalloc size to accommodate this memory size and testing all the 
other targets to make sure no regressions are introduced.  But given it 
is easy to change the default via the kernel cmdline, and that you lose 
only 8 MB otherwise, I don't think it is worth the trouble and/or the 
risk.


Nicolas
