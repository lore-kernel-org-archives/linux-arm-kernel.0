From: james.morse@arm.com (James Morse)
Date: Thu, 08 Feb 2018 15:31:28 +0000
Subject: EDAC driver for ARMv8 L1/L2 cache
In-Reply-To: <HE1PR04MB207371A103409F815745F49A9AFA0@HE1PR04MB2073.eurprd04.prod.outlook.com>
References: <20180112173802.kb32zrxc5uhsjlxk@lakrids.cambridge.arm.com>
 <VI1PR04MB20780EF853A0822A6EFCFE449A170@VI1PR04MB2078.eurprd04.prod.outlook.com>
 <20180112180048.srniseo2ft7ytqve@lakrids.cambridge.arm.com>
 <VI1PR04MB2078FCB86150A2AABFE7AB439A170@VI1PR04MB2078.eurprd04.prod.outlook.com>
 <20180113113156.nnmkuh25rilzwf4p@pd.tnic>
 <20180115142154.rj6cgnhlll7ivyew@lakrids.cambridge.arm.com>
 <20180115143249.tod4rqzn3udk6wmu@pd.tnic>
 <VI1PR04MB20786DE6AE24D4BB555E87C69AEB0@VI1PR04MB2078.eurprd04.prod.outlook.com>
 <20180115232321.ojo3lfvces2q2qhm@pd.tnic>
 <VI1PR04MB207883AE86B7685B9D9DE3029AEB0@VI1PR04MB2078.eurprd04.prod.outlook.com>
 <20180115235248.snzpl5cajfkudluw@pd.tnic>
 <HE1PR04MB207371A103409F815745F49A9AFA0@HE1PR04MB2073.eurprd04.prod.outlook.com>
Message-ID: <5A7C6D50.2000101@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi York,

On 01/02/18 20:56, York Sun wrote:
> On 01/15/2018 03:52 PM, Borislav Petkov wrote:
>> On Mon, Jan 15, 2018 at 11:28:14PM +0000, York Sun wrote:
>>> It is generic ARM64 thing. I believe only SError interrupt is available.
>>
>> So if it is, then I'd suggest you hammer out a proper design with the
>> ARM folks.

> I made some progress and need some help on coding. On the platform I am
> working on, it has A53 cores. Each A53 core has a signal nINTERRIRQ.
> They are connected to one GIC interrupt.

Is this a fatal signal for the CPU that should have received it? The signals
start out as being per-cpu, but configured like this you can only take the
interrupt one one CPU...

(is this thing edge or level triggered?)


> I managed to inject errors to some safe address without triggering system
> error and I got the interrupt.

(okay, sounds like its a corrected error)


> I will need to find out which core has errors by reading
> register on each core (and clear the interrupt). How can I do this
> within interrupt service routine? I tried to use
> smp_call_function_single() but it doesn't like the IRQ being disabled.

mm/memory-failure.c:memory_failure_queue() has an example of how you could do
this. It uses 'schedule_work_on()' to re-run after the IRQ, from there you
should be able to call something like on_each_cpu() or smp_call_function_many().

If this thing is level triggered you can't escape the irq-handler until its
cleared. If it needs clearing by a remote CPU this is going to be a problem.


Thanks,

James
