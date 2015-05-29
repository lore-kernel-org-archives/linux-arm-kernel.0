From: uwe@congenio.de (Dr. Uwe Meyer-Gruhl)
Date: Fri, 29 May 2015 21:53:10 +0200
Subject: [PATCH 0/1] mv643xx_eth: Disable TSO by default
In-Reply-To: <556864A1.2040908@vanguardiasur.com.ar>
References: <55680447.4070503@congenio.de>
 <556864A1.2040908@vanguardiasur.com.ar>
Message-ID: <5568C3A6.5080206@congenio.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Am 29.05.2015 um 15:07 schrieb Ezequiel Garcia:
> On 05/29/2015 03:16 AM, Dr. Uwe Meyer-Gruhl wrote:
>>> On Wed, Nov 05, 2014 at 08:39:26AM +0000, Ian Campbell wrote:
>>>> On Tue, 2014-11-04 at 15:20 +0100, Karl Beldan wrote:
>>>>> On Sat, Nov 01, 2014 at 12:30:19PM -0300, Ezequiel Garcia wrote:
>>>>>> Several users ([1], [2]) have been reporting data corruption
>>>>>> with TSO on Kirkwood platforms (i.e. using the mv643xx_eth
>>>>>> driver).
>>>>>>
>>>>>> Until we manage to find what's causing this, this simple patch
>>>>>> will make
>>>>>> the TSO path disabled by default. This patch should be queued
>> for stable,
>>>>>> fixing the TSO feature introduced in v3.16.
>>>>>>
>>>>>> The corruption itself is very easy to reproduce: checkingmd5sum on
>>>>>> a mounted
>>>>>> NFS directory gives a different result each time. Same tests  using
>>>>>> the mvneta
>>>>>> driver (Armada 370/38x/XP SoC) pass with no issues.
>>>>>>
>>>>>> Frankly, I'm a bit puzzled about this, and so any ideas ordebugging
>>>>>> hints
>>>>>> are well received.
>>>>>>
>>>>> Hi,
>>>>>
>>>>> Can you try this :
>>>> It fixes things for me, thanks!
>>>>
>>>> Tested-by: Ian Campbell <ijc@hellion.org.uk>
>>>>
>>> Good thing, thanks for your feedbak Ian !
>>>
>>> Karl --
>> That would be a good thing - although: Neither the patch to disable TSO
>> altogether nor the one that fixes the underlying problem actually made
>> it to the official kernel source tree, so it is still present in all
>> kernels > 3.16 - I just stumbled over this in the current 4.0.4 version.
>>
>> The fixes in the thread
>> http://marc.info/?l=linux-netdev&m=141517941900547&w=2 are not
>> applicable any more to the current driver from the 4.0 kernel, as the
>> whole respective logic seems to have been changed meanwhile, sadly
>> without fixing the problem. Disabling TSO completely still works, though.
>>
>> Can someone in the know please suggest a working fix to the kernel
>> maintainers, preferably one that does not resort to disable TSO?
>>
> Hello Uwe,
>
> Thanks for reporting. There wasn't any patch left behind. The above fix
> was merged (and applied to the stable tree) as this commit:
>
> commit 2c2a9cbd64387d6b70ac5db013e9bfe9412c7354
> Author: Karl Beldan <karl.beldan@rivierawaves.com>
> Date:   Wed Nov 5 15:32:59 2014 +0100
>
>      net: mv643xx_eth: reclaim TX skbs only when released by the HW
>
> Can you explain in detail what sort of problem are you running into,
> which kernel version are you using, etc.?
Sure, the same kind as had been reported initially.

Background: I have done a Debian port running on an Iomega iConnect (a 
Kirkwood variant).

One of my users reported corrupted data when he used the machine as a 
file and media server over Samba and DLNA. He ruled out any hardware or 
other faults and pointed to my kernel(s). He actually tried versions 
3.18.1 and 4.0.4. However, my kernels are mostly plain vanilla from 
kernel.org without any relevant patches to the code itself. The user 
also found that a kernel 3.14 ran O.K. in the same context.

When I tried, I could just use md5sum on the /usr subtree repeatedly 
without problems locally, but over NFS with the iConnect as a server, I 
had differences on every try in different files each time.

After ruling out network issues as well, it was clear that the NIC 
driver must be the culprit and after a bit of searching which one it 
actually was, I quickly found the messages about the broken TSO feature 
in mv643xx_eth. Then, I tried the suggested fix of "ethtool -K eth0 tso 
off" and voila - the errors are gone. For now, I use a patch to change 
the default to TSO off, but an upstream patch to handle TSO correctly 
would be much better.


Uwe
-- 


-------------- next part --------------
A non-text attachment was scrubbed...
Name: smime.p7s
Type: application/pkcs7-signature
Size: 3740 bytes
Desc: S/MIME Cryptographic Signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150529/12a23844/attachment.p7s>
