From: agnel.joel@gmail.com (Joel Fernandes)
Date: Thu, 17 Apr 2014 11:53:19 -0500
Subject: [Qemu-devel] [PATCH] QEMU: ARM: boot: Load kernel at an Image
 friendly address
In-Reply-To: <534FD87C.4090708@codeaurora.org>
References: <1395718484-20424-1-git-send-email-joelf@ti.com>
 <CAFEAcA9Dc5bN_JdMNWODB9Puj9HLoEBm4mDo7ZcaJj97qBbAdw@mail.gmail.com>
 <CAEgOgz6Tou7aOOKsWO2cOaPjWJrkWBFyU-_bApf+ks=qzSKDdA@mail.gmail.com>
 <CAFEAcA-1hWT69JzSv2zJta_PCCuJ-9fH7muBGPD=u+WOLHmvXQ@mail.gmail.com>
 <CAFEAcA96XGvwPM=OpqW8EU5nFksiEruGgncwqUPEWeU2ryCoJg@mail.gmail.com>
 <534FD87C.4090708@codeaurora.org>
Message-ID: <CAD=GYpaoNyFcgFNo50EUaGfDsiNkgpAAUgXrVa30kihqRbcJzw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 17, 2014 at 8:34 AM, Christopher Covington
<cov@codeaurora.org> wrote:
> On 04/17/2014 06:02 AM, Peter Maydell wrote:
>> On 2 April 2014 13:47, Peter Maydell <peter.maydell@linaro.org> wrote:
>>> On 2 April 2014 13:11, Peter Crosthwaite <peter.crosthwaite@xilinx.com> wrote:
>>>> Like others, I have been carrying this change locally. Good to see it up!
>>>
>>> Why are you all booting raw Images anyway (just out of curiosity)?
>>
>> Given the recent feedback from the kernel mailing list (viz "don't boot
>> Image unless you really know what you're doing, the correct load
>> image may change randomly depending what other board support
>> is in a multikernel image, etc") maybe we should just remove the
>> Image booting support instead? Clearly nobody who hasn't locally
>> patched QEMU is using it at the moment...
>
> An opportunity for a fresh start at low-level loading facilities, should
> anyone be inclined to pursue it, sounds good to me.
>
> Christopher
>
> --

I'm still wondering here, multi-arch may break, but we can put a
disclaimer in the Qemu code stating so that Image loading is not
recommended and risky. Clearly that's better than just deleting raw
Image loading functionality from Qemu boot loader altogether?

We can load the Image at any good address to make sure maximum number
of TEXT_OFFSETs are happy. I found this exercise in part making
__fixup_pv_table happy. Again I'm *not* advocating a hack, but I'm a
bit against the idea of just removing the code.

Nicholas idea is great to store TEXT_OFFSET in the start of stext and
parse it from bootloader but we wouldn't want to mainline those kernel
changes for just those few users, makes sense.

Peter, were you saying instead that we deprecate Image loading and
switch to uImage for those folks requiring uncompressed loading in
Qemu? IIRC uImage just wraps zImage so doesn't help folks not
requiring compression, but no reason why mkimage can't be made to do
that- just that the kernel doesn't do it by default (Correct me if I'm
wrong).

I'm not a big fan of raw image loading for that matter ;-) I only did
it because at one point, compressed image loading was breaking with
OMAP1 on Qemu and uncompressed Image loading was breaking because of
offset.

thanks,
  -Joel
