From: ezequiel@vanguardiasur.com.ar (=?UTF-8?Q?Ezequiel_Garc=C3=ADa?=)
Date: Tue, 29 Apr 2014 10:50:25 -0300
Subject: [PATCH v2] ARM: dts: am33xx: Move the cppi41dma node so it's
 probed early
In-Reply-To: <535F6C33.9040408@linutronix.de>
References: <1398373881-23369-1-git-send-email-ezequiel@vanguardiasur.com.ar>
 <CAGm1_kvHtSLNEfkJ24xZGGzsqAjHDTM1XztnX-QGs4iM5voMUw@mail.gmail.com>
 <535F5BA5.6000903@ti.com> <535F5D6B.6090802@linutronix.de>
 <535F6276.4050601@ti.com> <535F6C33.9040408@linutronix.de>
Message-ID: <CAAEAJfChJPN8gy89qsyenibWuKmNOaQUc-GFzoXTirv=Z8mCag@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 29 April 2014 06:09, Sebastian Andrzej Siewior <bigeasy@linutronix.de> wrote:
> On 04/29/2014 10:27 AM, George Cherian wrote:
>> Hi Sebastian,
>
> Hi George,
>
>> On 4/29/2014 1:36 PM, Sebastian Andrzej Siewior wrote:
>>> On 04/29/2014 09:58 AM, George Cherian wrote:
>>>>>> This is easily fixed by moving the node at the beggining of the child
>>>>>> list,
>>>>>> so it's probed first.
>>>> This will give issues on module removal.
>>>> Since we use device_for_each_child in remove patch, it will try to
>>>> remove cppi dma controller, while the channel
>>>> is still in use by musb node.
>>> Isn't this currently disabled because it blew up in the phy code?
>> Yes. So how if the dt  looks like this
>
> No. I remember we talked about this and we decided not to duct tape the
> bug by moving the nodes around. Instead we wanted to disable the child
> removal part (one tiny module that can't be removed) until the PHY code
> does no longer blow up.
> If the same case is for the DMA driver then it should be fixed, too.
> The order of the nodes in .dts should not crash the kernel under any
> circumstances. If a different node order accelerates the probing then
> fine. But a crash is a no no.
>

I still don't see any reason to have the DMA controller node as a
child of the USB.
However, it seems we need it this way for now; at least until we get
rid of the hwmod
altogether.

That said, this DT-ordering to fix other issues is starting to seem a
very bad idea.
I'll prepare a v3 to leave the DT as it is, and instead force the
driver to probe and
remove the childs so the DMA is probed first and the removed last.

We can always get rid of such workaround, once we can remove the DMA controller
out of the USB - as it should be.
-- 
Ezequiel Garc?a, VanguardiaSur
www.vanguardiasur.com.ar
