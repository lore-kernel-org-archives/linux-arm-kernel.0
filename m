From: jassisinghbrar@gmail.com (Jassi Brar)
Date: Tue, 9 Feb 2016 21:05:20 +0530
Subject: [PATCH 1/2] Documentation: dt: mailbox: Add TI Message Manager
In-Reply-To: <CABb+yY24XzsWaSGLMCE4_nvgWx0OhhQmcaP41g06FxdjQYFchg@mail.gmail.com>
References: <1454690044-2560-1-git-send-email-nm@ti.com>
 <1454690044-2560-2-git-send-email-nm@ti.com>
 <CABb+yY3kGq_R49Xx4fK3UMqtuFiuv-pXJWvjkEFLPL9xRu5T4A@mail.gmail.com>
 <56B9DC30.5040806@ti.com>
 <CABb+yY24XzsWaSGLMCE4_nvgWx0OhhQmcaP41g06FxdjQYFchg@mail.gmail.com>
Message-ID: <CABb+yY3cUU6VAkev57sQB7vLGPAwh0YEAb3unsZ+h=Tvm5Nr2Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 9, 2016 at 8:24 PM, Jassi Brar <jassisinghbrar@gmail.com> wrote:
> On Tue, Feb 9, 2016 at 6:01 PM, Nishanth Menon <nm@ti.com> wrote:
>> On 02/08/2016 10:14 PM, Jassi Brar wrote:
>>

>>>> +
>>> I think we should get rid of consumer specifics from the provider node...
>>
>>
>> If I get rid of the consumer nodes, how do you propose I describe the rx
>> queue interrupt(s) in the msmgr dt node (Every Rx queue will have it's
>> own interrupt - and it cannot be reverse computed from queue ID, proxy ID)?
>>
> One option is to have controller driver construct interrupt name from
> queue and proxy ids like
>
> msgmgr: msgmgr at 02a00000 {
>    ....
>      interrupt-names = "irq_5_2", "irq_0_0";     /* irq_<queue-id>_<proxy-id> */
>      interrupts = <GIC_SPI 324 IRQ_TYPE_EDGE_RISING>,
>                         <GIC_SPI 325 IRQ_TYPE_EDGE_RISING>;
> }
>
> and have the consumer specify queue and proxy ids in mboxes property like
>  pmmc {
>        ....
>        mbox-names = "tx", "rx";
>        mboxes = <&msgmgr 0 0>
>                           <&msgmgr 5 2>;
> };
>
However if the queue+proxy+interrupt tuple is a hard property of a
channel (which it seems to me now), then probably your original scheme
of chile node phandle is just as fine.

Thanks
