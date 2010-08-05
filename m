From: michael.williamson@criticallink.com (Michael Williamson)
Date: Thu, 05 Aug 2010 15:39:36 -0400
Subject: [PATCH v3] davinci: Add MityDSP-L138/MityARM-1808 SOM support
In-Reply-To: <87mxt0ubnr.fsf@deeprootsystems.com>
References: <4C45AE5E.7070905@criticallink.com>	<B85A65D85D7EB246BE421B3FB0FBB59301E7D0AF64@dbde02.ent.ti.com>	<4C4D8449.9040706@criticallink.com>
	<87mxt0ubnr.fsf@deeprootsystems.com>
Message-ID: <4C5B1378.7080400@criticallink.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

 On 8/5/2010 3:01 PM, Kevin Hilman wrote:

> Michael Williamson <michael.williamson@criticallink.com> writes:
>
>>  On 7/26/2010 5:29 AM, Nori, Sekhar wrote:
>>
>>>
>>> Hi Michael,
>>>
>>> On Tue, Jul 20, 2010 at 19:40:38, Michael Williamson wrote:
>>>>  This patch adds support for the MityDSP-L138 and MityARM-1808 system on
>>>> module (SOM) under the registered machine "mityomapl138".  These SOMs
>>>> are based on the da850 davinci CPU architecture.  Information on these
>>>> SOMs may be found at http://www.mitydsp.com.
>>>>
>>>> Signed-off-by: Michael Williamson <michael.williamson@criticallink.com>
>>>> ---
>>>
>>> [...]
>>>
>>>>
>>>>  arch/arm/configs/da8xx_omapl_defconfig             |  291 ++++++--
>>>>  arch/arm/include/asm/setup.h                       |    5 +
>>>>  arch/arm/mach-davinci/Kconfig                      |    7 +
>>>>  arch/arm/mach-davinci/Makefile                     |    1 +
>>>>  arch/arm/mach-davinci/board-mityomapl138.c         |  793 ++++++++++++++++++++
>>>>  .../mach-davinci/include/mach/cb-mityomapl138.h    |  125 +++
>>>>  arch/arm/mach-davinci/include/mach/da8xx.h         |    1 +
>>>>  arch/arm/mach-davinci/include/mach/uncompress.h    |    1 +
>>>>  8 files changed, 1181 insertions(+), 43 deletions(-)
>>>>
>>>
>>> [...]
>>>
>>>> diff --git a/arch/arm/include/asm/setup.h b/arch/arm/include/asm/setup.h
>>>> index f392fb4..d6b1a47 100644
>>>> --- a/arch/arm/include/asm/setup.h
>>>> +++ b/arch/arm/include/asm/setup.h
>>>> @@ -143,6 +143,11 @@ struct tag_memclk {
>>>>      __u32 fmemclk;
>>>>  };
>>>>
>>>> +/** MityDSP-L138 peripheral configuration info,
>>>> +  *  see arch/arm/mach-davinci/include/mach/cb-mityomapl138.h
>>>> +  */
>>>> +#define ATAG_PERIPHERALS 0x42000101
>>>
>>> Instead of naming this so generic, can you call this ATAG_MITYDSPL138 or
>>> something like that?
>>
>>
>>
>> Yes.  I would be glad to rename it, assuming some other approach is not
>> used instead.
>>
>>>
>>> Since passing peripheral configuration from bootloader is a first for
>>> DaVinci, can you please explain why this is the best suited method for this
>>> board and why methods used on other boards wont work?
>>>
>>
>>
>>
>> Well, the problem we are struggling with is that we'd like to avoid
>> generating a pile of separate machine types for the different boards
>> that are needed to support for this common SOM part with regards
>> to the peripheral selection.  There are already have 4 different
>> boards with slightly different peripherals already being used with this SOM,
>> and it's a challenge enough just to try to get one configuration through
>> this cycle (which I am new to).  We are expecting many more (10's per
>> year). 
>>
>> In general, the only real difference on any of these boards will be in regards
>> to peripheral selection/configuration.  E.G., using RMII vs. MII, or using
>> different McASP pins or different numbers of channels, or adding a couple
>> of SPI devices on different chip selects, LCD settings, etc. 
>> Seems like we shouldn't need to make a whole new machine up to support
>> these kinds of things. 
>>
>> This came up in a thread on this mailing list, see
>>
>> http://www.mail-archive.com/davinci-linux-open-source at linux.davincidsp.com/msg17042.html
>>
>> The approach here was pretty much what Kevin suggested as an alternate
>> to trying to port a flat device tree implementation like the powerpc
>> folks use.  The only difference was that I didn't think I could jam
>> everything I wanted onto the kernel command line without it getting out
>> of hand, so I am proposing a separate ATAG to provide the peripheral
>> configuration.  It's not perfect, but I wanted to get something out
>> there as if it's rejected then we only have a few boards to rewrite code
>> for.
>>
>> Other than device trees, the only other approaches I've seen so far to
>> sort out altering peripheral configuration is:
>>
>> a) Make a new board (a new board file, etc., KConfig option, etc.)
>>
>> b) Start in with a pile of #ifdefs, etc., and add a lot of peripheral
>> on/off options to the KConfig/Make system.  That means supporting
>> many variants of kernels for the different host boards, not
>> just an EVM.  I'd like to avoid that if I could, as the regression
>> testing for new options might get out of hand.  And it didn't seem
>> consistent with making a flexible kernel.
>>
>> c) Allow peripheral drivers to probe and initialize pins, etc. in the
>> modules, then load the right drivers up for your board.  There are a lot
>> of threads about why letting drivers mess with the pins is bad.  So this
>> is a non-starter.
>
> d) use ATAG_REVISION and a single board file
>
> There is currently a tag called ATAG_REVISION which sets a global
> variable 'system_rev' based on this tagq.  This tag was intended for
> exactly this purpose.
>
> You can then have a single machine type, a single board file and the
> boot loader can change ATAG_REVISION based on the board specifics.  The
> board file can then check 'system_rev' and handle specifics that way.
>
> This is also much clearer as all the things that are unique to that
> board will be contained in the board file and not hidden away in the
> bootloader.



So, if for example, we have 3 boards that use this SOM, and they
vary by desired peripheral:

Host Board 1 Peripherals = UARTS 0 and 1, SPI0 CS2, RMII, etc.
Host Board 2 Peripherals = UARTS 1 and 2, SPI1 CS1, MII, etc.
Host Board 3 Peripherals = UARTS 0, 1 and 2, SPI1 CS1, MII, etc.

Then by this approach we would have:

mityomapl138_init()
{
   /* Common NAND/NOR Init */

   switch (system_rev) {
      case 1:
          /* setup uarts 0 & 1, SPI0 CS2, RMII */
      case 2:
          /* setup uarts 1 & 2, SPI1 CS1, MII */
      case 3:
      default:
          /* setup uarts 0 & 1 & 2, SPI1 CS1, MII */
          /* and so forth.... */
   }

   /* Common Peripheral Init */
}

Each time a new board is developed to use the SOM, you then grow the init
code accordingly?  I was hoping not to have to continuously drop patches
for new boards using this SOM.  I was really trying to have one binary
kernel that would be flexible enough to support the peripherals that
need to be handed to the device framework for any host board using this
SOM (properly configured via bootloader).  Is this not possible?

Thanks for the insight.

-Mike
