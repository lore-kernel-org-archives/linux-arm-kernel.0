From: jonathan.austin@arm.com (Jonathan Austin)
Date: Fri, 11 Jan 2013 18:00:28 +0000
Subject: [PATCH] ARM: let CPUs not being able to run in ARM mode enter
 in THUMB mode
In-Reply-To: <20130111160753.GC23505@n2100.arm.linux.org.uk>
References: <1357904397-8476-1-git-send-email-u.kleine-koenig@pengutronix.de>
 <20130111160753.GC23505@n2100.arm.linux.org.uk>
Message-ID: <50F0533C.8070802@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Russell, Uwe

On 11/01/13 16:07, Russell King - ARM Linux wrote:
> On Fri, Jan 11, 2013 at 12:39:57PM +0100, Uwe Kleine-K?nig wrote:
>> +# Select this if your CPU doesn't support the 32 bit ARM instructions.
>> +config THUMBONLY_CPU
>> +	bool
>> +	select THUMB2_KERNEL
>> +	select ARM_THUMB
> 
> Hmm, not convinced this is the best solution.  Yes, fine for there to be
> a THUMBONLY_CPU option, _but_ not the select statements onto user visible
> symbols.  We can get this instead by:

I'm curious what it is about having the select statements onto user
visible symbols that isn't good. Is it just that it will manipulate
things underneath the users' feet? 

(I'm not disagreeing! I like your proposal, but when I saw the
original patch this didn't raise flags with me, so I'd like to
understand the reasons)

> config CPU_ARM
> 	bool
> 
> config CPU_THUMB
> 	bool

The only thing I might add is that we don't want people confusing
the selection of THUMB2_KERNEL with exclusively selecting CPU_THUMB
(which should be very rare). The latter would imply the former, but
in almost all cases where THUMB2_KERNEL is selected we should also
have CPU_ARM selected...

However things fall out, I'd still like to be *unable* to use
THUMBONLY_CPU *with* an MMU, as it is a clear sign (at least for the
foreseeable future) that something has been misunderstood.

Jonny
