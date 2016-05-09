From: javier@osg.samsung.com (Javier Martinez Canillas)
Date: Mon, 9 May 2016 08:48:16 -0400
Subject: [RESEND PATCH] [media] s5p-mfc: don't close instance after free
 OUTPUT buffers
In-Reply-To: <1462584301.25248.40.camel@collabora.com>
References: <1462572682-5195-1-git-send-email-javier@osg.samsung.com>
 <1462584301.25248.40.camel@collabora.com>
Message-ID: <ef0eb150-450b-96db-5f04-45271643f5c6@osg.samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Nicolas,

Thanks for your feedback.

On 05/06/2016 09:25 PM, Nicolas Dufresne wrote:
> Thanks for re-submitting. See inline two typos to fix in teh comment.
>

You are welcome, as we talked in IRC you needed this to make video decoding
in your Exynos4412 Odroid X2 board, so it would be great if you can provide
your Reviewed or Acked by tags.
 
> cheers,
> Nicolas
> 
> Le vendredi 06 mai 2016 ? 18:11 -0400, Javier Martinez Canillas a ?crit :
>> From: ayaka <ayaka@soulik.info>
>>
>> User-space applications can use the VIDIOC_REQBUFS ioctl to determine if a
>> memory mapped, user pointer or DMABUF based I/O is supported by the driver.
>>
>> So a set of VIDIOC_REQBUFS ioctl calls will be made with count 0 and then
>> the real VIDIOC_REQBUFS call with count == n. But for count 0, the driver
>> not only frees the buffer but also closes the MFC instance and s5p_mfc_ctx
>> state is set to MFCINST_FREE.
>>
>> The VIDIOC_REQBUFS handler for the output device checks if the s5p_mfc_ctx
>> state is set to MFCINST_INIT (which happens on an VIDIOC_S_FMT) and fails
>> otherwise. So after a VIDIOC_REQBUFS(n), future VIDIOC_REQBUFS(n) calls
>> will fails unless a VIDIOC_S_FMT ioctl calls happens before the reqbufs.
>>
>> But applications may first set the format and then attempt to determine
>> the I/O methods supported by the driver (for example Gstramer does it) so
>  * GStreamer
>

Right, sorry about that. I'll wait for other people feedback and fix in v2.

>> the state won't be set to MFCINST_INIT again and VIDIOC_REQBUFS will fail.
>>
>> To avoid this issue, only free the buffers on VIDIOC_REQBUFS(0) but don't
>> close the MFC instance to allow future VIDIOC_REQBUFS(n) calls to succeed.
>>
>> Signed-off-by: ayaka <ayaka@soulik.info>
>> [javier: Rewrote changelog to explain the problem more detailed]
>> Signed-off-by: Javier Martinez Canillas <javier@osg.samsung.com>
>>
>> ---
>> Hello,
>>
>> This is a resend of a patch posted by Ayaka some time ago [0].
>> Without $SUBJECT, trying to decode a video using Gstramer fails
> 
> * GStreamer again 
>

Yes, this is not that important since the comments between the --- separator
and the actual diff is stripped and doesn't end in the commit message.

Best regards,
-- 
Javier Martinez Canillas
Open Source Group
Samsung Research America
