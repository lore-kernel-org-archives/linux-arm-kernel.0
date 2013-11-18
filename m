From: swarren@wwwdotorg.org (Stephen Warren)
Date: Mon, 18 Nov 2013 15:46:32 -0700
Subject: [RFC PATCH V2 2/2] kbuild: dtbs_install: new make target
In-Reply-To: <20131118195243.GJ10335@titan.lakedaemon.net>
References: <1384201760-16785-1-git-send-email-jason@lakedaemon.net>
 <cover.1384798508.git.jason@lakedaemon.net>
 <eaf050fbd62803784856a4f37d4b332f7778e22c.1384798508.git.jason@lakedaemon.net>
 <528A65DF.8060000@wwwdotorg.org>
 <20131118191955.GG10335@titan.lakedaemon.net>
 <528A6944.3070303@wwwdotorg.org>
 <20131118192852.GI10335@titan.lakedaemon.net>
 <528A6CA3.9030904@wwwdotorg.org>
 <20131118195243.GJ10335@titan.lakedaemon.net>
Message-ID: <528A98C8.9040803@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/18/2013 12:52 PM, Jason Cooper wrote:
> On Mon, Nov 18, 2013 at 12:38:11PM -0700, Stephen Warren wrote:
>> On 11/18/2013 12:28 PM, Jason Cooper wrote:
>>> On Mon, Nov 18, 2013 at 12:23:48PM -0700, Stephen Warren wrote:
>>>> On 11/18/2013 12:19 PM, Jason Cooper wrote:
>>>>> On Mon, Nov 18, 2013 at 12:09:19PM -0700, Stephen Warren wrote:
>>>>>> On 11/18/2013 11:38 AM, Jason Cooper wrote:
>>>>>>> Unlike other build products in the Linux kernel, the devicetree blobs
>>>>>>> are simply the name of their source file, s/dts/dtb/.  There is also no
>>>>>>> 'make *install' mechanism to put them in a standard place with a
>>>>>>> standard naming structure.
>>>>>>>
>>>>>>> Unfortunately, users have begun scripting pulling the needed dtbs from
>>>>>>> within the kernel tree, thus hardcoding the dtbs names.  In turn, this
>>>>>>> means any changes to the dts filenames breaks these scripts.
>>>>>>>
>>>>>>> This patch is an attempt to fix this problem.  Akin to 'make install',
>>>>>>> this creates a new make target, dtbs_install.  The script that gets
>>>>>>> called defers to a vendor or distribution supplied installdtbs binary,
>>>>>>> if found in the system.  Otherwise, the default action is to install a
>>>>>>> given dtb into
>>>> ...
>>>>>> This only appears to create ${compat}.dtb, and not ${dtb} too. 
>>>>>
>>>>> See my comment, above.
>>>>>
>>>>>> So, it doesn't seem to address part of the cover letter, "In addition,
>>>>>> some vendors have done a diligent job naming their devicetree source
>>>>>> files appropriately and we don't want to break their setups." Was that
>>>>>> deliberate? If so, I guess I need to send some patches to U-Boot.
>>>>>
>>>>> I assume you are still pulling from arch/arm/boot/dts/*.dtb, right?
>>>>> Those build products don't go away with this patch, so you should be
>>>>> fine.  Unless I'm mis-understanding your workflow...
>>>>
>>>> Yes, but I thought the whole point of this was that everyone would/could
>>>> switch to running "make dtbs_install", then pulling out the files from
>>>> the install tree, instead of any use-case requiring obtaining files
>>>> directly from the source/build tree?
>>>
>>> Yes, in the script, it checks for the existence of /sbin/installdtbs.
>>> If it's there, it will override the default behavior and execute that
>>> script.
>>
>> But that means everyone (a lot of people, and all distros) has to write,
>> or at least download and install, such a script. 
> 
> They would already be modifying their build environment to make use of
> 'make dtbs_install', and few extra lines of shell script to integrate
> with existing systems certainly isn't unreasonable?
> 
>> Equally, that script would incorrectly affect the naming of non-Tegra
>> DTBs that follow the new convention. The naming of the Tegra DTBs is
>> based more on the fact that they're the Tegra DTBs than the fact that
>> I'm using them.
> 
> Umm, I wrote that script in 2 minutes.  I'm sure you could come up with
> something Tegra-specific (perhaps using fdtget?) that places only the
> Tegra dtbs in the location that works with Tegra's u-boot.

Again, the point is not that it's hard to write the script. As you
demonstrated, it's easy. The problem is that then, everybody has to do
something different for Tegra, forever. No matter how small the actual
cost of doing it is, it's still non-scalable to require that everyone
know about this special case. I'm not convinced the issue would be
isolated to Tegra either.

The whole point of "make dtbs_install" is that people can run it, and
get the results they're expected to use. If this isn't the case, what
exactly is the point of any of the renaming that "make dtbs_install" is
doing?

Certainly, it makes sense to have a "make dtbs_install" target, to
isolate DTB consumers from the source locations of the DTBs.

However, if "make dtbs_install" is doing anything other than just
copying files (i.e. if it does any kind of renaming at all), then it had
better do *everything* that's required to solve *all* cases, and not
just solve the one case you care about.
