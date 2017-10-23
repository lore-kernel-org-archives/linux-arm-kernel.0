From: Bart.VanAssche@wdc.com (Bart Van Assche)
Date: Mon, 23 Oct 2017 21:08:36 +0000
Subject: [bug report] regression bisected to "block: Make most
 scsi_req_init() calls implicit"
In-Reply-To: <20171023154129.iik3ic36i5fi7sqs@xps13.dannf>
References: <20171020225420.utvoqmtwit2isalc@xps13.dannf>
 <1508542254.3029.24.camel@wdc.com>
 <20171023154129.iik3ic36i5fi7sqs@xps13.dannf>
Message-ID: <1508792914.2634.6.camel@wdc.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2017-10-23 at 09:41 -0600, dann frazier wrote:
> (gdb) list *(sg_io+0x120)
> 0xffff0000084e71a8 is in sg_io (./include/linux/uaccess.h:113).
> 108	static inline unsigned long
> 109	_copy_from_user(void *to, const void __user *from, unsigned long n)
> 110	{
> 111		unsigned long res = n;
> 112		might_fault();
> 113		if (likely(access_ok(VERIFY_READ, from, n))) {
> 114			kasan_check_write(to, n);
> 115			res = raw_copy_from_user(to, from, n);
> 116		}
> 117		if (unlikely(res))

Hello Dann,

Would it be possible to check whether the patch below is sufficient to fix this?

Thanks,

Bart.


diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
index 34e17ee799be..15e11a519801 100644
--- a/drivers/block/virtio_blk.c
+++ b/drivers/block/virtio_blk.c
@@ -597,6 +597,7 @@ static const struct blk_mq_ops virtio_mq_ops = {
 	.queue_rq	= virtio_queue_rq,
 	.complete	= virtblk_request_done,
 	.init_request	= virtblk_init_request,
+	.initialize_rq_fn = scsi_initialize_rq,
 	.map_queues	= virtblk_map_queues,
 };
 
diff --git a/drivers/scsi/sg.c b/drivers/scsi/sg.c
index 0419c2298eab..14096f67eebb 100644
--- a/drivers/scsi/sg.c
+++ b/drivers/scsi/sg.c
@@ -1722,6 +1722,8 @@ sg_start_req(Sg_request *srp, unsigned char *cmd)
 	}
 	req = scsi_req(rq);
 
+	WARN_ON_ONCE(!req->cmd);
+
 	if (hp->cmd_len > BLK_MAX_CDB)
 		req->cmd = long_cmdp;
 	memcpy(req->cmd, cmd, hp->cmd_len);
