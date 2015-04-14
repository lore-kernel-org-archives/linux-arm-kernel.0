From: kishon@ti.com (Kishon Vijay Abraham I)
Date: Tue, 14 Apr 2015 19:51:09 +0530
Subject: [PATCHv2 2/3] usb: ehci-platform: Use devm_of_phy_get_by_index
In-Reply-To: <20150414132745.GA5650@kroah.com>
References: <1428963047-23666-1-git-send-email-arun.ramamurthy@broadcom.com>
 <6483716.157BQAaRqF@wuerfel> <20150414123737.GB18756@kroah.com>
 <2433709.D3gBAte9Iu@wuerfel> <20150414132745.GA5650@kroah.com>
Message-ID: <552D2255.1050704@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Tuesday 14 April 2015 06:57 PM, Greg Kroah-Hartman wrote:
> On Tue, Apr 14, 2015 at 03:17:30PM +0200, Arnd Bergmann wrote:
>> On Tuesday 14 April 2015 14:37:37 Greg Kroah-Hartman wrote:
>>> On Tue, Apr 14, 2015 at 01:33:08PM +0200, Arnd Bergmann wrote:
>>>> This is true, but all other drivers do the same for GENERIC_PHY at the
>>>> moment. If this one gets changed, we should probably apply the same
>>>> solution to all current users and fix them consistently.
>>>>
>>>> We can do one of these two:
>>>>
>>>> a) make sure that the framework has 'static inline' stubs that let you
>>>>     build all drivers using it when the framework itself is disabled.
>>>
>>> Yes, please do that.
>>>
>>>> b) change the drivers using it to 'depends on', and make GENERIC_PHY
>>>>     itself a hidden option without a Kconfig prompt.
>>>
>>> Then how could GENERIC_PHY ever get set?
>>
>> Right now, every driver that provides a phy uses 'select GENERIC_PHY',
>> and they would have to keep doing that. This is not unlike what we
>> do for other silent symbols like MFD_CORE, REGMAP_I2C, or PINCTRL,
>> and it's not as problematic as 'select' on a user-visible option,
>> or (worst) mixing 'select' and 'depends on'.
>
> Ok, that would make more sense, but it would be good for the PHY
> maintainer to agree to it as well :)

looking at [1], we should use select only for non-visible symbols and for 
symbols with no dependencies. As such GENERIC_PHY is not dependent on other 
symbols but for now it is "visible".

phy-core has all the stubs already implemented in include/linux/phy/phy.h. So 
removing select GENERIC_PHY shouldn't be a problem. But then it might break a 
few platforms where GENERIC_PHY is indirectly enabled by selecting the config 
of the driver (using default defconfigs in arch/arm/configs).

The simplest thing would be to make GENERIC_PHY an invisible option?

[1] -> 
https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/tree/Documentation/kbuild/kconfig-language.txt#n111

Thanks
Kishon
