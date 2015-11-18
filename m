From: jeremy.linton@arm.com (Jeremy Linton)
Date: Wed, 18 Nov 2015 13:31:18 -0600
Subject: [PATCH] [PATCH] arm64: Boot failure on m400 with new cont PTEs
In-Reply-To: <20151118180434.GB13355@leverpostej>
References: <1447858999-26665-1-git-send-email-jeremy.linton@arm.com>
 <20151118152044.GD10644@leverpostej> <564CA29A.9050905@arm.com>
 <20151118162932.GA13355@leverpostej> <564CB1DA.4090304@arm.com>
 <20151118180434.GB13355@leverpostej>
Message-ID: <564CD206.9040402@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/18/2015 12:04 PM, Mark Rutland wrote:

> You're racing against other parts of the CPU (the page table walker(s),
> I-caches, etc). The flushing only minimises the window for a race, and
> does not prevent the race from being possible.
>
> Given that the envelope is constantly pushing forward w.r.t. how
> aggressive CPUs may be in this area, we need to fix the issue by
> reasoning against what the architecture guarantees us.
	Its also not suppose to fault on speculative access, and to me that 
means page table walks/etc that are the result of speculative access. 
Which AFAIK, closes the window significantly. I would only really worry 
about interrupt activity, and updates to the memory containing the PTE's 
themselves. Either way the simple change (rather than rewriting the 
whole code path) is probably to flag the fault handler to simply resume 
from these kinds of faults during create_mapping_late().

	But that isn't what is happening here AFAIK, the faults are long after 
the PTE's have been updated, and are the result of failure to flush the 
TLB..
