From: robdclark@gmail.com (Rob Clark)
Date: Wed, 7 Aug 2013 09:27:36 -0400
Subject: [RFC 0/1] drm/pl111: Initial drm/kms driver for pl111
In-Reply-To: <CALAqxLW_rjS_bbDXDrPrnBRLbegs9TVmPDnpNVYuoQjaVv3tPw@mail.gmail.com>
References: <1374772648-19151-1-git-send-email-tom.cooksey@arm.com>
 <CAF6AEGtspnhSGNM4_QQubVfOkZ1Gh1-Z3iyHOLBPVWuqRy81ew@mail.gmail.com>
 <51f29ccd.f014b40a.34cc.ffffca2aSMTPIN_ADDED_BROKEN@mx.google.com>
 <CAF6AEGvFPGueM_LHVij9KFzM6NJySHCzmaLstuzZkK5GwP+6gQ@mail.gmail.com>
 <51ffdc7e.06b8b40a.2cc8.0fe0SMTPIN_ADDED_BROKEN@mx.google.com>
 <CAF6AEGsyKk_G-R-OX_YcgYFDgTEmCy9Vf2LV1pAOV0452QKSww@mail.gmail.com>
 <5200deb3.0b24b40a.3b26.ffffbadeSMTPIN_ADDED_BROKEN@mx.google.com>
 <CAF6AEGvXcpTKrTjhvrycLqab6F9QP5fAk0ZEWxJ-WvE==PiPsA@mail.gmail.com>
 <CALAqxLW_rjS_bbDXDrPrnBRLbegs9TVmPDnpNVYuoQjaVv3tPw@mail.gmail.com>
Message-ID: <CAF6AEGuq3f3yyOc-jP7ZhwS=hbz70zB3fsc+d9FVJCZmwrAmGQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 7, 2013 at 12:23 AM, John Stultz <john.stultz@linaro.org> wrote:
> On Tue, Aug 6, 2013 at 5:15 AM, Rob Clark <robdclark@gmail.com> wrote:
>> well, let's divide things up into two categories:
>>
>> 1) the arrangement and format of pixels.. ie. what userspace would
>> need to know if it mmap's a buffer.  This includes pixel format,
>> stride, etc.  This should be negotiated in userspace, it would be
>> crazy to try to do this in the kernel.
>>
>> 2) the physical placement of the pages.  Ie. whether it is contiguous
>> or not.  Which bank the pages in the buffer are placed in, etc.  This
>> is not visible to userspace.  This is the purpose of the attach step,
>> so you know all the devices involved in sharing up front before
>> allocating the backing pages.  (Or in the worst case, if you have a
>> "late attacher" you at least know when no device is doing dma access
>> to a buffer and can reallocate and move the buffer.)  A long time
>
> One concern I know the Android folks have expressed previously (and
> correct me if its no longer an objection), is that this attach time
> in-kernel constraint solving / moving or reallocating buffers is
> likely to hurt determinism.  If I understood, their perspective was
> that userland knows the device path the buffers will travel through,
> so why not leverage that knowledge, rather then having the kernel have
> to sort it out for itself after the fact.

If you know the device path, then attach the buffer at all the devices
before you start using it.  Problem solved.. kernel knows all devices
before pages need be allocated ;-)

BR,
-R
