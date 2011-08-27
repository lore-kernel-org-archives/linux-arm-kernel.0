From: ming.lei@canonical.com (Ming Lei)
Date: Sat, 27 Aug 2011 23:33:26 +0800
Subject: [PATCH] usb: ehci: fix update qtd->token in qh_append_tds
In-Reply-To: <20110827151317.GA10013@kroah.com>
References: <1314456515-16419-1-git-send-email-ming.lei@canonical.com>
	<20110827151317.GA10013@kroah.com>
Message-ID: <CACVXFVM_p_XPyOOgz7kbEo93SCCxPa4X_vjYGm+fUGMPSFM4EA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Sat, Aug 27, 2011 at 11:13 PM, Greg KH <greg@kroah.com> wrote:
> On Sat, Aug 27, 2011 at 10:48:35PM +0800, ming.lei at canonical.com wrote:
>> From: Ming Lei <ming.lei@canonical.com>
>>
>> This patch fixs one performance bug on ARM Cortex A9 dual core platform,
>> which has been reported on quite a few ARM machines(OMAP4, Tegra 2, snowball...),
>> see details from link of https://bugs.launchpad.net/bugs/709245.
>>
>> In fact, one mb() on ARM is enough to flush L2 cache, but
>> 'dummy->hw_token = token;' after mb() is added just for obeying
>> correct mb() usage.
>
> Really? ?A mb() should not be flushing any caches, it's just a memory
> barrier. ?Or is ARM somehow "special" in this way?

As Santosh pointed out, mb on ARM will flush L2 write buffer. The
description here is wrong.

I think the below should make the writing reach into memory on all
ARCH after ' token = dummy->hw_token;' is executed.

                       dummy->hw_token = token;
                       mb()
                       token = dummy->hw_token;

The above is the idea introduced to fix the problem.

>
>> The patch has been tested ok on OMAP4 panda A1 board, the performance
>> of 'dd' over usb mass storage can be increased from 4~5MB/sec to
>> 14~16MB/sec after applying this patch.
>
> That's impressive, but I don't think this is really the proper way to do
> this...
>
>> Signed-off-by: Ming Lei <ming.lei@canonical.com>
>> ---
>> ?drivers/usb/host/ehci-q.c | ? 14 ++++++++++++++
>> ?1 files changed, 14 insertions(+), 0 deletions(-)
>>
>> diff --git a/drivers/usb/host/ehci-q.c b/drivers/usb/host/ehci-q.c
>> index 0917e3a..65b5021 100644
>> --- a/drivers/usb/host/ehci-q.c
>> +++ b/drivers/usb/host/ehci-q.c
>> @@ -1082,6 +1082,20 @@ static struct ehci_qh *qh_append_tds (
>> ? ? ? ? ? ? ? ? ? ? ? wmb ();
>> ? ? ? ? ? ? ? ? ? ? ? dummy->hw_token = token;
>>
>> + ? ? ? ? ? ? ? ? ? ? /* The mb() below is added to make sure that
>> + ? ? ? ? ? ? ? ? ? ? ?* 'token' can be writen into qtd, so that ehci
>> + ? ? ? ? ? ? ? ? ? ? ?* HC can see the up-to-date qtd descriptor. On
>> + ? ? ? ? ? ? ? ? ? ? ?* some archs(at least on ARM Cortex A9 dual core),
>> + ? ? ? ? ? ? ? ? ? ? ?* writing into coherenet memory doesn't mean the
>> + ? ? ? ? ? ? ? ? ? ? ?* value written can reach physical memory
>> + ? ? ? ? ? ? ? ? ? ? ?* immediately, and the value may be buffered
>> + ? ? ? ? ? ? ? ? ? ? ?* inside L2 cache. 'dummy->hw_token = token;'
>> + ? ? ? ? ? ? ? ? ? ? ?* after mb() is added for obeying correct mb()
>> + ? ? ? ? ? ? ? ? ? ? ?* usage.
>> + ? ? ? ? ? ? ? ? ? ? ?* */
>> + ? ? ? ? ? ? ? ? ? ? mb();
>> + ? ? ? ? ? ? ? ? ? ? token = dummy->hw_token;
>
> Your comment does not match the code, so something is wrong here.

If you mean "L2 cache flush", I confess to the mistaken description,
and will update it later. If you mean others, could you help to point it out?

thanks,
--
Ming Lei
