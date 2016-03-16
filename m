From: bert@a20.net (Bert Lindner)
Date: Thu, 17 Mar 2016 00:56:40 +0100
Subject: 4.5.0 on sun7i-a20-olinuxino-lime2: libphy: PHY stmmac-0:ffffffff
 not found (regression from rc7)
In-Reply-To: <56E99B0C.2070609@arm.com>
References: <56E9413D.9010902@a20.net> <56E945FF.6080005@arm.com>
 <56E94CF4.2060607@arm.com> <56E95B57.1090100@suse.de>
 <56E9776F.3070102@a20.net> <56E99B0C.2070609@arm.com>
Message-ID: <56E9F2B8.1030605@a20.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2016-03-16 18:42, Marc Zyngier wrote:
> On 16/03/16 15:10, Bert Lindner wrote:
>> On 2016-03-16 14:10, Andreas F?rber wrote:
>>> Am 16.03.2016 um 13:09 schrieb Robin Murphy:
>>>> On 16/03/16 11:39, Marc Zyngier wrote:
>>>>> On 16/03/16 11:19, Bert Lindner wrote:
>>>>>> Hopefully this is the correct place and way to report this.
>>>
>>> The main discussion is on netdev list actually, CC'ed.
>>>
>>>>>> For the board sun7i-a20-olinuxino-lime2, there seems to be a problem
>>>>>> with the eth0 PHY in mainline kernel 4.5.0 that developed since
>>>>>> 4.5.0-rc7. Ethernet does not work, although eth0 is reported:
>>>>>>
>>>>>> root at lime2-079f:~# ip a l eth0
>>>>>> 2: eth0: <BROADCAST,MULTICAST> mtu 1500 qdisc noop state DOWN group
>>>>>> default qlen 1000
>>>>>>         link/ether 02:c9:05:02:07:9f brd ff:ff:ff:ff:ff:ff
>>>>>>
>>>>>>      Difference reported in dmesg:
>>>>>>
>>>>>> 4.5.0-rc7:
>>>>>> [    9.379279] NET: Registered protocol family 10
>>>>>> [   10.217148]  RX IPC Checksum Offload disabled
>>>>>> [   10.217195]  No MAC Management Counters available
>>>>>> [   10.217627] IPv6: ADDRCONF(NETDEV_UP): eth0: link is not ready
>>>>>> [   15.206250] sun7i-dwmac 1c50000.ethernet eth0: Link is Up -
>>>>>> 1Gbps/Full - flow control off
>>>>>> [   15.206360] IPv6: ADDRCONF(NETDEV_CHANGE): eth0: link becomes ready
>>>>>>
>>>>>> 4.5.0:
>>>>>> [    9.767125] NET: Registered protocol family 10
>>>>>> [   10.357405] libphy: PHY stmmac-0:ffffffff not found
>>>>>> [   10.362382] eth0: Could not attach to PHY
>>>>>> [   10.366557] stmmac_open: Cannot attach to PHY (error: -19)
>>>>>>
>>>>>> .config is identical for both, also after make oldconfig, apart from
>>>>>> comment with version number. DTB file is also identical between the two
>>>>>> versions.
>>>>>>
>>>>>> Kernels are compiled on the board itself. /proc/version string:
>>>>>> Linux version 4.5.0-rc7 (root at lime2-079f) (gcc version 4.9.1
>>>>>> (Ubuntu/Linaro 4.9.1-16ubuntu6) ) #1 SMP Mon Mar 7 11:57:25 UTC 2016
>>>>>> Linux version 4.5.0 (root at lime2-079f) (gcc version 4.9.1 (Ubuntu/Linaro
>>>>>> 4.9.1-16ubuntu6) ) #1 SMP Tue Mar 15 11:39:01 UTC 2016
>>>>>>
>>>>>> Please let me know if more info is needed, if I should post complete
>>>>>> .config, test compile with a particular config or patch, etc. Part of
>>>>>> .config below.
>>>>>
>>>>> Can you please try reverting 88f8b1b ("stmmac: Fix 'eth0: No PHY found'
>>>>> regression") and report whether or not this changes anything? This seems
>>>>> to be the only stmac patch between -rc7 and release...
>>>>
>>>> Sounds like the same thing as the giant ongoing discussion thread here:
>>>>
>>>> http://thread.gmane.org/gmane.linux.drivers.devicetree/159007/focus=402830
>>>
>>> v4 fixes for 4.5 are here:
>>>
>>> https://patchwork.ozlabs.org/patch/598195/ (revert)
>>> https://patchwork.ozlabs.org/patch/598196/
>>>
>>> v2 fixes for linux-next here:
>>>
>>> https://patchwork.ozlabs.org/patch/598331/ (revert)
>>> https://patchwork.ozlabs.org/patch/598332/
>>>
>>> Please let Peppe know whether they work for you guys.
>>
>> Hi guys - I can confirm 4.5.0 minus 88f8b1b works for me:
>>
>> root at lime2-079f:~# cat /proc/version
>> Linux version 4.5.0-minus-88f8b1b (root at lime2-079f) (gcc version 4.9.1
>> (Ubuntu/Linaro 4.9.1-16ubuntu6) ) #2 SMP Wed Mar 16 12:50:03 UTC 2016
>>
>>   From dmesg output:
>> [    9.731730] NET: Registered protocol family 10
>> [   10.516893]  RX IPC Checksum Offload disabled
>> [   10.516948]  No MAC Management Counters available
>> [   10.517374] IPv6: ADDRCONF(NETDEV_UP): eth0: link is not ready
>> [   15.505548] sun7i-dwmac 1c50000.ethernet eth0: Link is Up -
>> 1Gbps/Full - flow control off
>> [   15.505660] IPv6: ADDRCONF(NETDEV_CHANGE): eth0: link becomes ready
>>
>> .. and connected over ethernet.
>
> Good to know, thanks. Could you also give the potential fix a go (as
> mentioned by Andreas)? Just to make sure that whatever gets merged next
> will actually fix the issue.

Yes sure, it took a while because I had to travel. Confirmed, the 
v4-for-4.5 fix works well for me, on sun7i-a20-olinuxino-lime2:

root at lime2-079f:~# cat /proc/version
Linux version 4.5.0-598195-598196-v4 (root at lime2-079f) (gcc version 
4.9.1 (Ubuntu/Linaro 4.9.1-16ubuntu6) ) #1 SMP Wed Mar 16 16:44:22 UTC 2016

dmesg:
[    8.245273] NET: Registered protocol family 10
[    9.297406]  RX IPC Checksum Offload disabled
[    9.297460]  No MAC Management Counters available
[    9.297951] IPv6: ADDRCONF(NETDEV_UP): eth0: link is not ready
[   16.285658] sun7i-dwmac 1c50000.ethernet eth0: Link is Up - 
1Gbps/Full - flow control rx/tx
[   16.285798] IPv6: ADDRCONF(NETDEV_CHANGE): eth0: link becomes ready

The board is connected to my laptop rather than to a switch, so that 
might be where the flow control message comes from (not sure). Anyway 
ethernet works.

I'm less familiar with linux-next - not sure what base to test against, 
I understand it is being redefined almost daily.

Thanks!

	-Bert
