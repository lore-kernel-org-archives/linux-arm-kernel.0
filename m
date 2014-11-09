From: f.fainelli@gmail.com (Florian Fainelli)
Date: Sun, 09 Nov 2014 11:24:34 -0800
Subject: [GIT PULL] Broadcom Cygnus SoC defconfig changes
In-Reply-To: <545EFF6E.7000309@broadcom.com>
References: <1414698612-26216-1-git-send-email-f.fainelli@gmail.com>
 <20141109001302.GB11947@quad.lixom.net> <545EFF6E.7000309@broadcom.com>
Message-ID: <545FBF72.10202@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/08/14 21:45, Scott Branden wrote:
> Hi Olof,
> 
> Thanks for the comments.  Please see my questions inline before we
> determine what needs to be done for the defconfig patchset.
> 
> On 14-11-08 04:13 PM, Olof Johansson wrote:
>> On Thu, Oct 30, 2014 at 12:50:09PM -0700, Florian Fainelli wrote:
>>> The following changes since commit
>>> f114040e3ea6e07372334ade75d1ee0775c355e1:
>>>
>>>    Linux 3.18-rc1 (2014-10-19 18:08:38 -0700)
>>>
>>> are available in the git repository at:
>>>
>>>    http://github.com/brcm/linux.git
>>> tags/arm-soc/for-3.18/cygnus-defconfig-v9
>>>
>>> for you to fetch changes up to aa0204801143ee2d47e9e8dd5f39cdddd5613b4b:
>>>
>>>    ARM: multi_v7_defconfig: Enable Broadcom Cygnus (2014-10-30
>>> 11:01:35 -0700)
>>
>> Hi Florian,
>>
>> Apologies for the delay in dealing with this pull request.
>>
>>> ----------------------------------------------------------------
>>> This patchset contains initial support for Broadcom's Cygnus SoC
>>> based on our
>>> iProc architecture. Initial support is minimal and includes just the
>>> mach
>>> platform code, clock driver, and a basic device tree configuration.
>>> Peripheral
>>> drivers will be submitted soon, as will device tree configurations
>>> for other
>>> Cygnus board variants.
>>>
>>> These are the defconfig parts of the changes
>>>
>>> ----------------------------------------------------------------
>>> Jonathan Richardson (1):
>>>        ARM: cygnus defconfig : Initial defconfig for Broadcom Cygnus SoC
>>>
>>> Ray Jui (1):
>>>        ARM: multi_v7_defconfig: Enable Broadcom Cygnus
>>>
>>> Scott Branden (1):
>>>        ARM: bcm_defconfig/multi_v7_defconfig: remove one level of
>>> menu from Kconfig
>>>
>>>   arch/arm/configs/bcm_cygnus_defconfig | 237
>>> ++++++++++++++++++++++++++++++++++
>>>   arch/arm/configs/bcm_defconfig        |   3 +-
>>>   arch/arm/configs/multi_v7_defconfig   |  21 ++-
>>
>> Please send multi_v7_defconfig updates as a patch instead of including in
>> a merge request. We ask for this because it's a file that many
>> maintainers
>> touch and it's easy that we get lots of conflicts otherwise.
> OK, easy to do.  Are there other files that we need to be aware of that
> have these different requirements to merge as well?
> 
>>
>> As far as the bcm_cygnus_defconfig: Since new platforms are multiplatform
>> enabled by default, we normally only prefer to have one defconfig per
>> vendor.
>> We've made exceptions in cases where the families are very different,
>> but in
>> general one defconfig per vendor should be sufficient.
>>
>> I.e. please enable the cygnus options in bcm_defconfig instead of
>> adding a new
>> one.
> 
> Hi Olof, we can do this.  But this makes bcm_defconfig unusable for us
> in a product and is not a simple configuration to start from for our
> customers.  bcm_defconfig is a different SoC family based around the
> Kona architecture. bcm_defconfig won't be what we build and test on
> Cygnus at all.  There is a script in scripts/kconfig/mergeconfig.pl that
> allows you to merge config files together if you wish to have a kernel
> support multiple SoCs.  I see the same problem with multi_v7_defconfig
> but even worse.  It isn't a configuration we will ever use.  Its only
> purpose seems to be to enable our drivers in the that build just in case
> somebody else happens to break something in the build.

The defconfigs shipped in the mainline kernel only serve the purpose of
building as many drivers/subsystems as possible and making sure they
work well together from a general distribution perspective like
Debian/Ubuntu/OE... That does not mean this is your configuration
template for a downstream kernel with only a specific set of SoCs to
support.

> 
> As it stands, multi_v7_defconfig boots noticably slower than
> bcm_cygnus_defconfig.  And, the kernel is larger than we want.  And, the
> kconfigs are more complicated than we need for our boards.  I also
> notice some of the other SoCs families enabled automatically turn on a
> lot of features we don't want on.

Right, you are also very likely to see code blow away that has been
enabled as part of the multi_v7_defconfig, but actually assumes that it
will only run on a a particular family of SoCs, of course, all of this
is good to fix to improve the multiplatform kernel, but does not
necessarily impact you directly.

> 
> Perhaps most of the multi_v7_defconfig merge issue you are facing could
> be solved if you used the mergconfig.pl script to merge multiple
> defconfigs together?
> 
> What we wish to do is have a config file that only supports the Cygnus
> family of SoCs.  This allows others to easily see what applies to Cygnus
> without being confused by other configurations.  And, if somebody wishes
> to use scripts/kconfig/mergeconfig.pl to merge different SoC support
> together they are free to do so.
> 
> So, we can do as you ask to get this upstreamed.  But it really serves
> little purpose for us other than verifying things build.
> 
> Where do we upstream the defconfig that we actually use?  Or is this
> just not done and everyone keeps everything locally and has to continue
> to maintain it there?

FWIW, this is typically what we do for the brcmstb_defconfig, it is just
present in our downstream kernel, but we do use the multi_v7_defconfig
when testing upstream.
--
Florian
