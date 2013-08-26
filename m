From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 26 Aug 2013 19:49:23 +0100
Subject: [Linaro-acpi] [PATCH 0/3] Interrupt priority patch set
In-Reply-To: <5f35febcdc4c4c1d929ccb6594450860@BY2PR07MB092.namprd07.prod.outlook.com>
References: <1377531385-19369-1-git-send-email-tomasz.nowicki@linaro.org>
 <20130826171501.GD6617@n2100.arm.linux.org.uk>
 <1db399be587d446b955bdc608d2a4260@BY2PR07MB092.namprd07.prod.outlook.com>
 <20130826181636.GE6617@n2100.arm.linux.org.uk>
 <5f35febcdc4c4c1d929ccb6594450860@BY2PR07MB092.namprd07.prod.outlook.com>
Message-ID: <20130826184923.GF6617@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 26, 2013 at 06:31:50PM +0000, Lurndal, Scott wrote:
> My primary concern about NMI vs. SEI is that SEI has the ability to mask
> the condition when using SEI to implement a kernel/hypervisor in-band
> debugging capability (i.e. the ability to interrupt & debug exception
> handlers, when the corresponding processor state bits mask SEI).

The reason why there's the A bit is to prevent two exceptions in
succession causing state to be irrecoverably lost.

Consider the case where you hit a page fault, which raises a data
abort.  The CPU has just switched to abort mode, and vectored to the
data abort handler.

An imprecise abort has been raised by an external peripheral at this
point due to a writeback.

At this point, the imprecise aborts are masked by the A bit.  This
prevents the abort from being raised while unsaved state which would
be lost if this was to cause a re-entry into the data abort handler.

So, what happens is that the first data abort is allowed to save its
state, and once the handler has saved that state, it can clear the A
bit, allowing the imprecise abort to then be safely received.

The failure to have this method of masking means that state is silently
and unknowingly corrupted; if you analyse what happens if the A bit
didn't exist, when you return from handling the imprecise abort, you
return to the beginning of the data abort handler.  That much is fine,
but the state you're about to save will be the same state as the
imprecise abort, which will lead you restart the data abort handling
when you finish that first data abort.

So, the A bit is very necessary.

Now, if you were to say that we weren't clearing the PSR A bit in
Aarch32 after we'd saved the necessary state, I'd agree with you, and
I'd wonder how that's been missed for soo long. :)
