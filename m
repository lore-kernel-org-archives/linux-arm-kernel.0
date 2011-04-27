From: matthieu.castet@parrot.com (Matthieu CASTET)
Date: Wed, 27 Apr 2011 14:38:02 +0200
Subject: [PATCH V2 2/2] mtd: msm_nand: Add initial msm nand driver support.
In-Reply-To: <4DB6C13F.2020402@codeaurora.org>
References: <1302938249-4601-1-git-send-email-mnalajal@codeaurora.org>
	<4DABE8FE.5040300@parrot.com> <4DB6C13F.2020402@codeaurora.org>
Message-ID: <4DB80E2A.4000203@parrot.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Murali Nalajala a ?crit :
> On 4/18/2011 1:02 PM, Matthieu CASTET wrote:
>> Hi,
>>
>> Murali Nalajala a ?crit :
>>> Add initial msm nand driver support for Qualcomm MSM platforms.
>>> This driver is capable of handling both 2k and 4k page support
>>> nand devices.
>>>
>>> This driver was originally developed by Arve Hj?nnev?g at google.
>>> Its source is available at
>>> http://android.git.kernel.org/?p=kernel/msm.git under
>>> android-msm-2.6.35 branch.
>>>
>>> CC: Dima Zavin<dima@android.com>
>>> CC: Brian Swetland<swetland@google.com>
>>> CC: Arve Hj?nnev?g<arve@android.com>
>>> Signed-off-by: Murali Nalajala<mnalajal@codeaurora.org>
>>> ---
>>> Changes in V2
>>> * Turn most of the pr_info() calls into pr_debug().
>>>
>>>   drivers/mtd/devices/Kconfig    |   11 +
>>>   drivers/mtd/devices/Makefile   |    1 +
>>>   drivers/mtd/devices/msm_nand.c | 1597 ++++++++++++++++++++++++++++++++++++++++
>>>   drivers/mtd/devices/msm_nand.h |   77 ++
>>>   4 files changed, 1686 insertions(+), 0 deletions(-)
>>>   create mode 100644 drivers/mtd/devices/msm_nand.c
>>>   create mode 100644 drivers/mtd/devices/msm_nand.h
>>>
>> For the record, I am not sure it is a great idea to make nand drivers
>> independent of the nand layer.
>> By doing that you could change the expected behavior, and introduce bug
>> difficult to debug.
>>
>> Why do you need that ? Nand drivers can override callbacks of nand framework.
>>
>> Maybe because the nand layer call the driver page per page, and  you want to
>> work with more than one page. But in this case you can extend nand layer.
>>
>> Or does your controller don't allow sending raw command ?
>> And in that case all the nand logic is in the nand controller ?
> 
> Our controller doesn't allow sending RAW commands to the flash. All 
> these commands are abstracted by the controller logic. Please refer the 
> msm_nand.h file where you will find the commands which are different 
> from the actual NAND device commands.
Ok, but does the controller does all other check : status check, ...

In the nand framework there is already controller like yours : see the denali.c
as example.
> 
> eg: To send read/write data command to the device we configure the 
> controller with page address & controller specific command. Then the 
> controller itself takes care of generating the internal h/w signals 
> required by the flash and it polls for the R/B signal & wait states are 
> internally controlled by the h/w.
> 
So you provide your own
    chip->ecc.read_page
    chip->ecc.read_page_raw
    chip->ecc.read_oob
    chip->write_page
    chip->ecc.write_oob

and your done.


Matthieu
