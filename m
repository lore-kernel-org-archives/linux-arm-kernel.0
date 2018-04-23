From: hdegoede@redhat.com (Hans de Goede)
Date: Mon, 23 Apr 2018 17:56:12 +0200
Subject: brcm, cyw_bt: Add latest Cypress/Murata firmware
In-Reply-To: <CAD0U-hJ5ebJa0s+myT-qdEhwCVraHake8-z5u7CVeo1G3gGwjQ@mail.gmail.com>
References: <1524146649-25267-1-git-send-email-ryan.harkin@linaro.org>
 <CA+5PVA57X8aPXXLBTfaWxhULY7EgWooWy1NQoNq+X=vLWm2Q2g@mail.gmail.com>
 <7b9d1310-e850-2331-a11b-b22de8282797@redhat.com>
 <CAD0U-hKiK62Efg=kj3=-MOeeVA-4g0HW-6TW8Jo-YNuUs5LEQg@mail.gmail.com>
 <da653c17-ea3d-8c97-64f3-b7c6ce80dcf1@redhat.com>
 <CAD0U-hJ5ebJa0s+myT-qdEhwCVraHake8-z5u7CVeo1G3gGwjQ@mail.gmail.com>
Message-ID: <09bc0fb5-4cbb-f4cd-32e5-40eaaa576b6b@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 23-04-18 17:51, Ryan Harkin wrote:
> 
> 
> On 23 April 2018 at 16:38, Hans de Goede <hdegoede at redhat.com <mailto:hdegoede@redhat.com>> wrote:
> 
>     Hi,
> 
>     On 23-04-18 14:51, Ryan Harkin wrote:
> 
>         Hi Hans,
> 
>         Thanks for your comments.
> 
>         On 20 April 2018 at 18:09, Hans de Goede <hdegoede at redhat.com <mailto:hdegoede@redhat.com> <mailto:hdegoede at redhat.com <mailto:hdegoede@redhat.com>>> wrote:
> 
>          ? ? Hi Ryan,
> 
> 
>          ? ? On 04/20/2018 03:27 PM, Josh Boyer wrote:
> 
>          ? ? ? ? On Thu, Apr 19, 2018 at 10:04 AM, Ryan Harkin <ryan.harkin at linaro.org <mailto:ryan.harkin@linaro.org> <mailto:ryan.harkin at linaro.org <mailto:ryan.harkin@linaro.org>>> wrote:
> 
>          ? ? ? ? ? ? Murata has created a github project for the firmware for their 43xx
>          ? ? ? ? ? ? family of devices:
> 
>         https://github.com/murata-wireless <https://github.com/murata-wireless> <https://github.com/murata-wireless <https://github.com/murata-wireless>>
> 
>          ? ? ? ? ? ? This project contains firmware binaries for their WiFi and BT parts
>          ? ? ? ? ? ? containing the Cypress IP.
> 
>          ? ? ? ? ? ? The binary files are licensed under the same LICENCE.cypress as present
>          ? ? ? ? ? ? in this repo already. The NVRAM files are text and are licensed under
>          ? ? ? ? ? ? GPLv2.
> 
>          ? ? ? ? ? ? This series copies the binaries from the github project into
>          ? ? ? ? ? ? linux-firmware where other downstream projects may benefit.
> 
>          ? ? ? ? ? ? The following changes since commit b562d2f3583f19ecda22b08e514ced57dd1e5f4d:
> 
>          ? ? ? ? ? ? ?? ?linux-firmware: update wil6210 firmware to 5.2.0.18 (2018-04-16 09:55:50 -0400)
> 
>          ? ? ? ? ? ? are available in the git repository at:
> 
>         https://git.linaro.org/landing-teams/working/mbl/linux-firmware.git <https://git.linaro.org/landing-teams/working/mbl/linux-firmware.git> <https://git.linaro.org/landing-teams/working/mbl/linux-firmware.git <https://git.linaro.org/landing-teams/working/mbl/linux-firmware.git>> rmh-murata-update
> 
> 
>          ? ? ? ? ? ? for you to fetch changes up to 53bd09779d9b378316a2b81ec55f4b20033d4542:
> 
>          ? ? ? ? ? ? ?? ?cyw_bt: add Cypress 43xx Bluetooth patch files (2018-04-18 14:05:28 +0100)
> 
>          ? ? ? ? ? ? ----------------------------------------------------------------
>          ? ? ? ? ? ? Ryan Harkin (3):
>          ? ? ? ? ? ? ?? ? ? ?brcm: update firmware from Murata repo
>          ? ? ? ? ? ? ?? ? ? ?brcm: add fmac nvram files
>          ? ? ? ? ? ? ?? ? ? ?cyw_bt: add Cypress 43xx Bluetooth patch files
> 
> 
>          ? ? ? ? I'm looping in Hans, who was discussing this with me the other day.
>          ? ? ? ? He had some concerns that I'll let him express better than I can.
> 
> 
>          ? ? Thanks,
> 
>          ? ? So my concerns are 2 fold:
> 
>          ? ? 1) Practical:
> 
>          ? ? The brcmfmac4*-sdio.txt and brcmfmac4*-pci.txt files are nvram
>          ? ? files (which replace having an actual eeprom on the board)
>          ? ? are board specific, I've been discussing with upstream to modify
>          ? ? the driver to load these nvram files using a board specific name.
> 
>          ? ? This never got very far because I never got permission to
>          ? ? redistribute the nvram files for the board which I have, see
>          ? ? point 2 below.
> 
>          ? ? I believe that at a minimum these patches should be modified
>          ? ? to drop the .txt files for now until we've added a mechanism
>          ? ? for the driver to load a board specific version (using DMI
>          ? ? strings on x86 and info from DT on ARM) and then they should
>          ? ? be upstreamed under the board-specific filename.
> 
> 
>         I see your point, but I'd like to suggest an alternative idea.
> 
>         The files that Murata have released are the generic/example/sample nvram files. Some boards use these generic files, other boards need modified versions.
> 
>         The code as it is today expects the nvram file to be in the same location as the binary blob and to have the same filename as the blob, only with an .txt ending instead of .bin. Getting these generic files into linux-firmware right away could solve problems for quite a few people like me.
> 
> 
>     Sorry, but no, NACK. There are several problems with what you suggest:
> 
>     1) One of the big differences is the crystal frequency (typically 27.4 or 36 MHz),
>     getting this wrong means everything appears to work, but nothing will actually
>     work, greatly confusing users. Actually getting an error their is no nvram
>     file is better then a non working config with no clear signs of what is wrong.
> 
>     2) 1. means that using the nvram means that any packets send out to actively
>     discover accesspoints will be send on wrong frequencies outside of the
>     free bands. The nvram files also contain antenna gain info, which means that
>     using a wrong file may cause us to send at a powerlevel which is higher then
>     than allowed in the free bands.
> 
>         After that, we could carry both generic and board specific variants in the linux-firmware repo as they become available and as the upstream code changes to cope with board variants.
> 
>         We could have the generic version either at the top level, as per my commit, or in it's own sub-dir. For each board that has its own version, we could have a sub-dir for all board specific files, where the board name is included in the filename using an defined pattern, eg. "<blob-filename>-<board-name>.txt". Or we could have a sub-dir for each board, although that doesn't seem as clean.
> 
>         For boards that use the generic version, like one of the boards I'm dealing with, they could either softlink to the generic file, or better still, the upstream code could drop back to the generic filename.
> 
> 
>     I agree that the upstream code should drop back to the generic filename, but
>     only to not break existing setups where people have located the right
>     nvram file and stored it under the current generic name, we don't want new
>     kernels to regress for those people.
> 
>     But IMHO for the reasons I outlined above we MUST NOT ship any nvram files
>     in linux-firmware under the generic names and once we've patches to try a board
>     specific name, we should probably use the new request_firmware_nowarn code which
>     is being queued up for 4.18, and use that for both the board-specific
>     and generic name tries and if both fail print an error showing only
>     the board-specific name.
> 
>         Using this method, I think we can make this additional board specific step as a separate patch, after the upstream code is modified and after my patch has been committed.
> 
> 
>     As said before (sorry) NACK, we really must NOT distribute nvram
>     files under generic names.
> 
> 
> That's fine. But I still think the generic files should be available in the repo for users who want to use them. Having them take an explicit step, like softlinking it to the board specific file, is fine by me. But I believe we should be able to get them if we wish to. At the very least, I would be interested in knowing how my board varies from the generic example given by Cypress/Murata/OEM.
> 
> So how about we add the files but either in a sub-dir, and/or with example/generic/sample as the board name? Eg, we could push this file:
> 
>  ? ? brcmfmac43430-sdio-generic.txt
> 
> As you suggested, the code could look for?brcmfmac43430-sdio-<board name>.txt, if it doesn't find it, fall back to brcmfmac43430-sdio.txt. In this case, brcmfmac43430-sdio-generic.txt will never automatically load.

Putting them in linux-firmware as brcmfmac4xxxx-sdio-generic.txt /
brcmfmac4xxx-pci-generic.txt is fine. Maybe with a fat comment at
the top of each file that if possible people should get a board
specific version (and a note that things may not work with the
generic version).

>     Writing a patch to make the brcmfmac code try a board specific-name
>     should not be that hard, for devicetree based boards, which I guess
>     your boards are, you can simply use of_flat_dt_get_machine_name()
>     to fill in the machine specific part. If you write a patch which
>     does the board-specific name thing for just dt platforms then I
>     can do a follow-up patch adding board-specific name support for x86
>     based boards (which are trickier because DMI info often contains
>     "Default String" and crap like that).
> 
> Ack, that makes sense and I'm happy to do that. I should be able to make a start on it this week.

Great, thanks.

Regards,

Hans
