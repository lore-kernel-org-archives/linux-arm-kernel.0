From: julien.thierry@arm.com (Julien Thierry)
Date: Thu, 22 Nov 2018 11:49:29 +0000
Subject: [PATCH 0/7] Ensure stack is aligned for kernel entries
In-Reply-To: <1537970184-44348-1-git-send-email-julien.thierry@arm.com>
References: <1537970184-44348-1-git-send-email-julien.thierry@arm.com>
Message-ID: <bf872be5-4a56-017b-83b6-544f8d8f528e@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 26/09/18 14:56, Julien Thierry wrote:
> Hi,
> 
> Having SCTLR_ELx.SA enabled requires the SP to be 16-bytes aligned before
> using it to access memory. When taking an exception, it is possible that
> the context during which the exception occured had SP mis-aligned. The
> entry code needs to make sure that the stack is aligned before using it to
> save the context.
> 

So, as discussed in this thread:
https://www.spinics.net/lists/arm-kernel/msg688342.html

We might have the compiler provide the guarantee that SP is kept at 
multiples of 16-bytes throughout C functions. If this is accepted, it 
avoids the complexity of this series.

There is just one case remaining, which is less important as it is 
mostly a debug concern. If we take an SP alignment fault from EL1 (due 
to bad implementation) we take recursive exceptions:

- Without CONFIG_VMAP_STACK, kernel just freezes always taking SP 
alignment faults
- With CONFIG_VMAP_STACK after taking a number of exceptions, we 
overflow the stack and the kernel switches to the overflow stack where 
it finally manages to display a kernel panic message

So the question is, do we care about doing something for the above case?

Thanks,

-- 
Julien Thierry
