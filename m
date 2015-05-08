From: khilman@kernel.org (Kevin Hilman)
Date: Fri, 08 May 2015 10:14:52 -0700
Subject: Possible regression due to "hrtimer: Get rid of hrtimer softirq"
In-Reply-To: <20150507132543.GA14889@verge.net.au> (Simon Horman's message of
 "Thu, 7 May 2015 22:25:43 +0900")
References: <20150507111711.GA17448@verge.net.au>
 <alpine.DEB.2.11.1505071425520.4225@nanos>
 <20150507132543.GA14889@verge.net.au>
Message-ID: <7hvbg3gfeb.fsf@deeprootsystems.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Simon Horman <horms@verge.net.au> writes:

> Hi Thomas,
>
> On Thu, May 07, 2015 at 02:35:59PM +0200, Thomas Gleixner wrote:
>> On Thu, 7 May 2015, Simon Horman wrote:
>> > ------------[ cut here ]------------
>> > kernel BUG at kernel/irq_work.c:135!
>> 
>>   BUG_ON(!irqs_disabled());
>> 
>> So something enables interrupts in the periodic tick handling
>> machinery. Seems you have high resolution timers disabled, but nohz
>> enabled. And that code path has a local_irq_disable/enable pair which
>> causes havoc. Patch below.
>
> Thanks for your quick response. I have been able to confirm that
> when applied on top of next-20150507 the problem I observed no longer
> manifests. I have successfully tested it on all the boards
> where I previously observed a problem.
>
> If you are planning to formally submit the patch below feel free to add:
>
> Tested-by: Simon Horman <horms+renesas@verge.net.au>

FWIW, I confirmed this fixed a boot hang on my kzm9d in next-20150507
also.

Tested-by: Kevin Hilman <khilman@linaro.org>
