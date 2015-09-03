From: ytk.lee@samsung.com (Yongtaek Lee)
Date: Thu, 03 Sep 2015 19:30:33 +0900
Subject: [PATCH] ARM: fix bug which lowmem size is limited to 760MB
In-Reply-To: <20150903091044.GW21084@n2100.arm.linux.org.uk>
References: <20150903091044.GW21084@n2100.arm.linux.org.uk>
Message-ID: <1441276233-14566-1-git-send-email-ytk.lee@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> Wrong, there is no such "rule".

> If we apply that rule, then if you have 1GB of RAM, it will fill from
> 0xc0000000 to 0xffffffff inclusive.  There will be _zero_ bytes of
> vmalloc space.  There will be _zero_ bytes of IO mappings.  There won't
> even be a vectors page, so the kernel _will_ crash on the first exception.
> The "rule" you think exists doesn't because it is wrong.

I am sorry disturb you again. 
I am confusing after reading your comment. 

So i summarize my opinion again. 

Current status.

768MB, no CONFIG_HIGHMEM and no vmalloc=size
lowmem : 0MB ~ 760MB
vmalloc : 768MB ~ VMALLOC_END
  => waste 8MB because 760MB ~ 768MB is hole

1GB, no CONFIG_HIGHMEM and no vmalloc=size
lowmem : 0MB ~ 760MB
vmalloc : 768MB ~ VMALLOC_END
 => waste 264MB, so we need to enable CONFIG_HIGHMEM to use full memory. 
highmem : 264MB if enable CONFIG_HIGHMEM 

after applying patch. 

768MB, no CONFIG_HIGHMEM and no vmalloc=size
lowmem : 0MB ~ 768MB
vmalloc : 776MB ~ VMALLOC_END
 => use 768MB fully

1GB, no CONFIG_HIGHMEM and no vmalloc=size
lowmem : 0MB ~ 768MB
vmalloc : 776MB ~ VMALLOC_END
 => waste 256MB, so we need to enable CONFIG_HIGHMEM to use full memory. 
highmem : 256MB if enable CONFIG_HIGHMEM
 => it will not fill from 0xc0000000 to 0xffffffff

My opinion is not that vmalloc area size should be changed for all cases(512M, 768M, 1GB, 2GB, etc.). 
If we change default value from 240MB to 232MB, it could covor all cases without 
any other changes so that i have suggested this patch. 


As we already talked there are 3 cases with 768MB
1. live with the truncation => waste 8MB so that it will not be acceptable. 
2. enable CONFIG_HIGHMEM => mm point of view it could make overhead because there is only 8MB(very small) in highmem. 
3. set vmalloc size manually => I already mentioned it could fix issue but 
if default value is suitable then it is needless.  

Anyway please think again which size is more efficient for all cases. 
If you still think this patch is not acceptable i will accept your decision. 

Thank you for your comment.
