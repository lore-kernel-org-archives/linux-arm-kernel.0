From: tomeu@tomeuvizoso.net (Tomeu Vizoso)
Date: Wed, 9 Mar 2016 09:35:13 +0100
Subject: [PATCH v3 0/8] arm64: rockchip: Initial GeekBox enablement
In-Reply-To: <CADhT+weKf+F98uxCQhRa2RfMm8+4p=rrNZc-Vf=w_HPycXto=A@mail.gmail.com>
References: <1457294038-14243-1-git-send-email-afaerber@suse.de>
 <56DD7172.4000707@suse.de> <2714888.1DdqvJZ8cb@diego>
 <56DD7593.5060003@suse.de>
 <56DD8176.2080603@st.com> <56DD8FBE.9010200@suse.de> <56DD99A4.5030004@st.com>
 <56DDA26C.3050301@suse.de> <56DDA3D5.3090209@st.com>
 <56DDB749.1020808@suse.de>
 <CADhT+wfO8x4En78g5ixnnwbpaeXJGDo+Q1sOABYsbXzNZy0CPw@mail.gmail.com>
 <56DE7E1D.5070508@st.com>
 <CADhT+weKf+F98uxCQhRa2RfMm8+4p=rrNZc-Vf=w_HPycXto=A@mail.gmail.com>
Message-ID: <CAAObsKD9HoEbtV_JMz_R=bcrQseDmhncRAWP9k8djksL-LMQqw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 8 March 2016 at 16:45, Dinh Nguyen <dinh.linux@gmail.com> wrote:
> On Tue, Mar 8, 2016 at 1:24 AM, Giuseppe CAVALLARO
> <peppe.cavallaro@st.com> wrote:
>> Hi Dinh,
>>
>> On 3/8/2016 12:22 AM, Dinh Nguyen wrote:
>> [snip]
>>>
>>>
>>> I'm seeing the same issue on the SoCFPGA platform:
>>>
>>> libphy: PHY stmmac-0:ffffffff not found
>>> eth0: Could not attach to PHY
>>> stmmac_open: Cannot attach to PHY (error: -19)
>>>
>>> If I just revert:
>>>
>>>   "stmmac: Fix 'eth0: No PHY found' regression"
>>>
>>> then the issue goes away.
>>
>>
>> do you have this patch "stmmac: first frame prep at the end of xmit routine"
>> ? Or you just reverted
>>   "stmmac: Fix 'eth0: No PHY found' regression"
>
> I only reverted "stmmac: Fix 'eth0: No PHY found' regression". I do have the
> patch "stmmac: first frame prep at the end of the xmit routine", but I did not
> need to revert that patch.

Hi,

in order to get the onboard network on the Radxa Rock2 to work at all
on today's linux-next, I had to revert both commits:

* "stmmac: Fix 'eth0: No PHY found' regression" for the drivers to
probe and the link to come up, and

* "stmmac: first frame prep at the end of the xmit routine" for the
network interface to work at all.

But a few seconds into the nfsroot boot I start getting:

[    9.136701] systemd[1]: Started Load Kernel Modules.
[   18.116321] nfs: server 10.42.0.1 not responding, still trying
[   18.516224] ------------[ cut here ]------------
[   18.521024] WARNING: CPU: 1 PID: 0 at net/sched/sch_generic.c:303
dev_watchdog+0x284/0x288
[   18.529456] NETDEV WATCHDOG: eth0 (rk_gmac-dwmac): transmit queue 0 timed out

I'm attaching the full boot log.

Regards,

Tomeu
-------------- next part --------------
A non-text attachment was scrubbed...
Name: rock2.log
Type: text/x-log
Size: 37321 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160309/c0b7c298/attachment-0001.bin>
