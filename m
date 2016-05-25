From: andy.gross@linaro.org (Andy Gross)
Date: Wed, 25 May 2016 16:15:29 -0500
Subject: [Patch v5 5/8] firmware: qcom: scm: Convert to streaming DMA APIS
In-Reply-To: <7hbn3tg8ul.fsf@baylibre.com>
References: <1463111221-6963-1-git-send-email-andy.gross@linaro.org>
 <1463111221-6963-6-git-send-email-andy.gross@linaro.org>
 <CAOi56cVB1Z-gO6Dx0KOSr9wiRF3Y9ahDHe0=qT9WW4MdFMhjng@mail.gmail.com>
 <CAPBZ5Qc0oZ+k_5OiUGU6c9jFfcmAfsK3Uy-s=ONGCSGzCDyYNw@mail.gmail.com>
 <20160525033731.GA30220@hector.attlocal.net>
 <7hbn3tg8ul.fsf@baylibre.com>
Message-ID: <CAPBZ5QdAYR2puF6SmfKi0khQ4BfcdTiW_j0_T43Gh03bZSf64Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 25 May 2016 at 15:50, Kevin Hilman <khilman@baylibre.com> wrote:
> Andy Gross <andy.gross@linaro.org> writes:
>
>> On Mon, May 23, 2016 at 04:02:06PM -0500, Andy Gross wrote:
>>> On 23 May 2016 at 14:26, Kevin Hilman <khilman@kernel.org> wrote:
>>> > Hi Andy,
>>> >
>>> > On Thu, May 12, 2016 at 8:46 PM, Andy Gross <andy.gross@linaro.org> wrote:
>>> >> This patch converts the Qualcomm SCM driver to use the streaming DMA APIs
>>> >> for communication buffers.
>>> >>
>>> >> Signed-off-by: Andy Gross <andy.gross@linaro.org>
>>> >
>>> > This patch has landed in linux-next in the form of commit a551c3dbd689
>>> > (firmware: qcom: scm: Convert to streaming DMA APIS), and kernelci.org
>>> > found some boot breakage in next-20160523 on apq8064[1] which was
>>> > bisected down to this commit.
>>> >
>>> > I reverted this commit on top of next-20160523 and it no longer
>>> > builds, so I didn't validate if things boot again with this patch
>>> > reverted.
>>>
>>> Ouch I missed this failure.  I'll investigate and get it fixed.
>>
>> So the root cause was the fact that the DFAB clock required by the SCM is an RPM
>> clock.  That support isn't present yet in the kernel, so SCM probe fails.
>>
>> The core clock is really only accessed so that we can bump the clock on it up to
>> the max for performance.  As such, I'll make it optional in the platform code.
>>
>> This does bring up the issue of probe defer causing issues with the spm driver,
>> as it calls set_warm_boot_addr.  That may have to be addressed, but is probably
>> a problem best fixed in the spm.
>
> Nice, thanks for the explanation.
>
> Is there a patch somewhere you'd like me to test? or were you able to
> dust off an 8064 platform for testing?

I had the ifc6410, but it took me a while to find the darn 5V supply.
The docs lie when they say 5V-12V.  In any case, I threw a patch on
top of next to fix this.  I need to amend my set of patches to include
these changes and add the DT information for the 8064.

Regards,

Andy
