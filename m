From: james.morse@arm.com (James Morse)
Date: Thu, 26 Nov 2015 14:23:37 +0000
Subject: [PATCH v2 10/11] PM / Hibernate: clean cached pages on
 architectures that require it
In-Reply-To: <1445966960-31724-11-git-send-email-james.morse@arm.com>
References: <1445966960-31724-1-git-send-email-james.morse@arm.com>
 <1445966960-31724-11-git-send-email-james.morse@arm.com>
Message-ID: <565715E9.4080805@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 27/10/15 17:29, James Morse wrote:
> Some architectures require code written to memory as if it were data to be
> 'cleaned' from any data caches so that the processor can fetch them as new
> instructions.
> 
> During resume from hibernate, the snapshot code copies some pages directly,
> meaning these architectures do not get a chance to perform their cache
> maintenance. Add a call to flush_icache_range(), which is provided by
> architectures that require it, to perform the maintenance.
> 
> This mirrors the kernel's behaviour when loading kernel modules and when
> mapping executable pages to user space.

While trying to benchmark the impact of this patch on 32bit ARM, I've
discovered the fix is in the wrong place! do_copy_page() isn't used on
the resume path for the pages restored 'in place'.

I will produce another version of the series - hopefully later today.



James
