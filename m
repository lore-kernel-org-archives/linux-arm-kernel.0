From: imirkin@alum.mit.edu (Ilia Mirkin)
Date: Fri, 8 Apr 2016 02:27:31 -0400
Subject: Nouveau crashes in 4.6-rc on arm64
In-Reply-To: <570737F5.30105@nvidia.com>
References: <57064992.1060509@arm.com>
	<570737F5.30105@nvidia.com>
Message-ID: <CAKb7Uvhyrr+QZTexM97pB1_vwyGBOHba9odn=Bkv0wOYmfemnw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 8, 2016 at 12:47 AM, Alexandre Courbot <acourbot@nvidia.com> wrote:
> Hi Robin,
>
> On 04/07/2016 08:50 PM, Robin Murphy wrote:
>>
>> Hello,
>>
>> With 4.6-rc2 (and -rc1) I'm seeing Nouveau blowing up at boot, from the
>> look of it by dereferencing some offset from NULL inside
>> nouveau_fbcon_imageblit(). My setup is an old XFX 7600GT card plugged
>> into an ARM Juno r1 board, which works fine with 4.5 and earlier.
>>
>> Attached are a couple of logs from booting arm64 defconfig plus DRM and
>> Nouveau enabled - the second also has framebuffer console rotation
>> turned on, which interestingly seems to move the point of failure, and
>> the display does eventually come up to show the tail end of the panic in
>> that case.
>>
>> I might be able to find time for a full bisection next week if isn't
>> something sufficiently obvious to anyone who knows this driver.
>
>
> Looking at the log it is not clear to me what could be causing this. I can
> boot 4.6-rc2 with a GM206 card without any issue. A bisect would indeed be
> useful here.

Presumably not on an arm64 board though. This is happening in the
memcpy done somewhere in fbcon, when doing an OUT_RINGp if the
backtrace is to be believed. This means that the fifo is somehow not
writable, or not set, or ... something. Also note that it's a G73 (aka
pre-G80), so very different paths being taken through the driver.

  -ilia
