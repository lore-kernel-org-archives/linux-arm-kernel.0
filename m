From: axboe@kernel.dk (Jens Axboe)
Date: Tue, 14 Aug 2018 10:26:51 -0600
Subject: Warning when using eMMC and partprobe: generic_make_request:
 Trying to write to read-only block-device
In-Reply-To: <22fff85b-63e5-3cfe-0e72-255044e53bab@kernel.dk>
References: <7f57199f45df7212fdbba0bd1e78142a@agner.ch>
 <CAOi1vP9Y5Nrr7kVo5GAKnS4casbXPa+LSgY=si=mAW6OHs7-BA@mail.gmail.com>
 <CA+55aFwyCmYfUrGt61d-6B=1XiTLoudNO=_bQ9-g_rDg8Ao_VA@mail.gmail.com>
 <22fff85b-63e5-3cfe-0e72-255044e53bab@kernel.dk>
Message-ID: <e5589461-6331-7c4c-4171-7d7e304410e0@kernel.dk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 8/14/18 10:24 AM, Jens Axboe wrote:
> On 8/14/18 10:22 AM, Linus Torvalds wrote:
>> On Tue, Aug 14, 2018 at 8:24 AM Ilya Dryomov <idryomov@gmail.com> wrote:
>>>
>>> Looks like it's coming from that fsync():
>>>
>>>   sys_fsync
>>>     do_fsync
>>>       vfs_fsync_range
>>>         blkdev_fsync
>>>           blkdev_issue_flush
>>>
>>> I think we need to teach blkdev_issue_flush() to bail out if the bdev
>>> is read-only, similar to blkdev_issue_discard(), _write_zeroes(), etc.
>>> The question is which error code to use.  blkdev_fsync() already skips
>>> over EOPNOTSUPP, so it is a (no-so-good) option.  Other blkdev_issue_
>>> functions return EPERM.
>>
>> Oh, just make issue_flush() return EROFS for a read-only device.
>>
>> Or maybe we should even just consider the flush to be a read operation?
>>
>> But I guess the error code gets percolated all the way to user space?
>> The safest option might just be to return 0.
> 
> We probably just want to special case a flush for this check. In other
> situations, like resource allocation and issue, we'd want to consider
> it a write.

Ala:


diff --git a/block/blk-core.c b/block/blk-core.c
index 12550340418d..29f8a60965bc 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -2162,7 +2163,9 @@ static inline bool should_fail_request(struct hd_struct *part,
 
 static inline bool bio_check_ro(struct bio *bio, struct hd_struct *part)
 {
-	if (part->policy && op_is_write(bio_op(bio))) {
+	const int op = bio_op(bio);
+
+	if (part->policy && (op_is_write(op) && !op_is_flush(op))) {
 		char b[BDEVNAME_SIZE];
 
 		WARN_ONCE(1,


-- 
Jens Axboe
