From: ming.lei@canonical.com (Ming Lei)
Date: Tue, 6 Dec 2011 14:30:34 +0800
Subject: [RFC PATCH v1 5/7] media: v4l2: introduce two IOCTLs for face
 detection
In-Reply-To: <201112051437.27538.arnd@arndb.de>
References: <1322817178-8931-1-git-send-email-ming.lei@canonical.com>
 <42689146.OPtqLboC2m@wuerfel>
 <CACVXFVO5Bu8vTfLN_WFsEkHW6JhQFmWPmEyNnrvTsDhoF-WVeA@mail.gmail.com>
 <201112051437.27538.arnd@arndb.de>
Message-ID: <CACVXFVMB+HuQDb+Pxo0d8x46P82-c-OPxaL0c661Wztyx3NWJA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Mon, Dec 5, 2011 at 10:37 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> On Sunday 04 December 2011, Ming Lei wrote:
>> >
>> > This data structure is not 32/64 bit safe: running a 64 bit kernel with 32 bit
>> > user space will see an incompatible layout.
>>
>> I agree that this is not 32/64 bit safe, but I understand lib32 can handle
>> this correctly, otherwise many 32bit applications can't run on current
>> 64bit kernel
>> since many kernel structures used by user space contained pointer,
>> such as struct v4l2_buffer, struct v4l2_ext_controls in v4l2 ABI.
>
> The other ones you mentioned are handled in the kernel in
> drivers/media/video/v4l2-compat-ioctl32.c. For new ioctl commands,
> it's better to define the data structure in a compatible way
> so you do not need a wrapper like that.

OK, I opt to use __u64 to pass the user pointer, so how about the blow
changes on this patch?

diff --git a/include/linux/videodev2.h b/include/linux/videodev2.h
index 073eb4d..8aeaa1e 100644
--- a/include/linux/videodev2.h
+++ b/include/linux/videodev2.h
@@ -2214,7 +2214,12 @@ struct v4l2_fd_result {
 	__u32	buf_index;
 	__u32	face_cnt;
 	__u32	reserved[6];
-	struct v4l2_fd_detection *fd;
+
+	/*make 64/32 compatible*/
+	union {
+		struct v4l2_fd_detection *fd;
+		__u64	dummy;
+	};
 };

 /**

thanks,
--
Ming Lei
