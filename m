From: linux@baker-net.org.uk (Adam Baker)
Date: Sat, 27 Feb 2016 20:06:58 +0000
Subject: net: mv643xx: interface does not transmit after some time
In-Reply-To: <CAAEAJfBFNEPRd+AaKpRAh6sKFJ=trO+mAD_DAAj3dzhAbbreqg@mail.gmail.com>
References: <E4F9E0D0-9DA8-4E33-9F89-B49E47F11CE0@schloeter.net>
 <20160206183414.GD17218@lunn.ch> <20160206231935.GA30734@jirafa.cyrius.com>
 <2ACB3A0B-DD51-43C1-A56E-E7C175645554@schloeter.net>
 <20160207203545.GB29107@lunn.ch>
 <A21B89D4-5826-4F97-A1C9-E62E5B724082@schloeter.net>
 <312E318A-CAE1-45B1-AB13-EA147B48E315@schloeter.net>
 <A6128DBC-59DB-4231-A08D-B84C1D8C26CC@schloeter.net>
 <20160210225717.GD14610@lunn.ch>
 <CAAEAJfBFNEPRd+AaKpRAh6sKFJ=trO+mAD_DAAj3dzhAbbreqg@mail.gmail.com>
Message-ID: <56D201E2.4060504@baker-net.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/02/16 14:38, Ezequiel Garcia wrote:
> (let's expand the Cc a bit)
>
> On 10 February 2016 at 19:57, Andrew Lunn <andrew@lunn.ch> wrote:
>> On Wed, Feb 10, 2016 at 07:40:54PM +0100, Thomas Schl?ter wrote:
>>>
>>>> Am 08.02.2016 um 19:49 schrieb Thomas Schl?ter <thomas@schloeter.net>:
>>>>
>>>>
>>>>> Am 07.02.2016 um 22:07 schrieb Thomas Schl?ter <thomas@schloeter.net>:
>>>>>
>>>>> Am 07.02.2016 um 21:35 schrieb Andrew Lunn <andrew@lunn.ch>:
>>>>>>
>>>>>>>> FWIW, we had a similar bug report in Debian recently:
>>>>>>>> https://lists.debian.org/debian-arm/2016/01/msg00098.html
>>>>>>
>>>>>> Hi Thomas
>>>>>>
>>>>>> I this thread, Ian Campbell mentions a patch. Please could you try
>>>>>> that patch and see if it fixes your problem.
>>>>>>
>>>>>> Thanks
>>>>>>    Andrew
>>>>>
>>>>> Hi Andrew,
>>>>>
>>>>> I just applied the patch and the NAS is now running it. I???ll try to crash it tonight and keep you informed whether it worked.
>>>>>
>>>>> Thanks
>>>>>     Thomas
>>>>
>>>> Hi Andrew,
>>>>
>>>> the patch did not fix the problem. After 1.2 GiB RX and 950 MiB TX, the interface crashed again.
>>>>
>>>> Now I switched off RX/TX offload just to make sure we are talking about the same problem. If we are, the interface should be stable without offload, right?
>>>>
>>>>      Thomas
>>>
>>> Okay, so I have installed ethtool and switched off all offload features available. Now the NAS is running rock solid for two days. I backed up my Mac using Time Machine / netatalk (450 GiB transferred) and some Linux machines via NFS (100 GiB total) without a problem.
>>>
>>> How much code is used for mv643xx offload functionality?
>>> Is it possible to debug things in the driver and figure out what happens during the crash?
>>> Is the hardware offload interface proprietary or reverse engineered or is it a well known API that can be analyzed?
>>
>> Hi Thomas
>>
>> Ezequiel Garcia probably knows this part of the driver and hardware
>> the best...
>>
>
> The TCP segmentation offload (TSO) implemented in this driver is
> mostly a software thing.
>
> I'm CCing Karl and Philipp, who have fixed subtle issues in the TSO
> path, and may be able to help figure this one out.
>

Hi,

Had this issue occur again today. In my case it seems to be triggered by 
large NFSv4 transfers.

I'm running 4.4 plus Nicolas Schichan's patch at
https://patchwork.ozlabs.org/patch/573334/

There is a thread a http://forum.doozan.com/read.php?2,17404 suggesting 
that this has been broken since at least 3.16.

I first spotted the issue when upgrading from 3.11 to 4.4.

Looking at 
https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/log/drivers/net/ethernet/marvell/mv643xx_eth.c 
I see 2014-05-22 as the date TSO support was first added which is 
shortly before the merge window opened for 3.16. I'm therefore guessing 
that TSO has been problematic since it's introduction.

Regards

Adam
