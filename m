From: nm@ti.com (Nishanth Menon)
Date: Wed, 10 Feb 2016 23:03:19 -0600
Subject: [PATCH 1/2] Documentation: dt: mailbox: Add TI Message Manager
In-Reply-To: <CABb+yY3nSZCbF7G1LP_7cGkKJpdJ1fko_6d3UkrF_vNpHk4uBg@mail.gmail.com>
References: <1454690044-2560-1-git-send-email-nm@ti.com>
 <1454690044-2560-2-git-send-email-nm@ti.com>
 <CABb+yY3kGq_R49Xx4fK3UMqtuFiuv-pXJWvjkEFLPL9xRu5T4A@mail.gmail.com>
 <56B9DC30.5040806@ti.com>
 <CABb+yY24XzsWaSGLMCE4_nvgWx0OhhQmcaP41g06FxdjQYFchg@mail.gmail.com>
 <CAGo_u6qGaQj9Qvjwrm7cD=cr2UjLN+62tcquXYPsQrRjYD=UCw@mail.gmail.com>
 <20160209181031.GA23603@kahuna>
 <CABb+yY3nSZCbF7G1LP_7cGkKJpdJ1fko_6d3UkrF_vNpHk4uBg@mail.gmail.com>
Message-ID: <56BC1617.3090204@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Jassi,

On 02/10/2016 10:23 PM, Jassi Brar wrote:
[...]


Thanks for taking the time and checking the TRM, I apologize that the
actual details of the hardware block which was supposed to be in
sections 8.1.3 and 8.1.4 has unfortunately been dropped since the last
time I reviewed in the spec Vs what actually went out into public
domain! I do realize the problem of doing a review without comprehensive
and accurate documentation - ugghh.. :(

But, I am trying to get our internal guys to upload the proper TRM
chapter in public domain -> hopefully we will get it done some time soon.


>>         msgmgr: msgmgr at 02a00000 {
>>                 compatible = "ti,k2g-message-manager";
>>                 #mbox-cells = <2>;
>>                 reg-names = "queue_proxy_region", "queue_state_debug_region";
>>                 reg = <0x02a00000 0x400000>, <0x028c3400 0x400>;
>>                 interrupt-names = "rx_005_002",
>>                                   "rx_057_002";
>>
> Looking at figure in page-1445, it seems QID is the h/w channel id,
> while proxy is its programming parameter. So maybe we need to list all
> the ARM irq's as a list here, matched only by the qid asked by the
> consumer ... assuming no two channels could have the same qid (?).

The overall story is something like what you already figured out..
message manager has a queue engine and a ram for data buffers, and n
queues. Each of these queues have a memory map corresponding to the
processor view.. we can call that programming paramater as well.

>   interrupt-names = "irq_005", "irq_037", "irq_049", "irq_057",
> "perr", "ferr", "eerr";

proxy error (perr), free index error(ferr) and ECC error(eerr) cannot be
handled by a slave, since it involves controlling a shared register set
for a single message manager instance. in the case of K2G, the master of
the message manager is actually PMMC, and not the compute processors -
it has error handling logic to handle things there - a slave can only
report these errors without ability to even expect reliable detection
(for example PMMC reacting even before any of  these cores have come up
from low power state).

irq_37 and irq_49 go to the secure world and we have no access from ARM
"non secure" world. the "missing documentation" would have helped
clarify that :(..

> 
> I may be slightly off, but the idea remains to not have to encode any
> consumer specific info in the provider node.

I do realize the reasoning behind your suggestion here. the reasoning
for providing rx_qid_pid as the interrupt name was as follows: I was
hoping to get a future SoC to provide proxy specific error instead of a
global error which is really useless since the processor generating
error should be the guy actually be notified.. queue specific interrupts
as well.. the reason for naming interrupts with the proxy id information
was primarily to let the dtb ABI stay compatible with only additional
properties defined when the new SoC gets supported.

I can make it compatible for today's SoC, but based on what i explained,
how about just "rx_<qid>" for the interrupt names?
interrupt-names = "rx_005", "rx_057" (I kinda feel using "irq" for
interrupt-names is actually redundant information)?

*if* i manage to convince to get a new IP with proxy specific
interrupts, then "perr_qid_pid" could then be introduced for that new
compatible type..

[...]
-- 
Regards,
Nishanth Menon
