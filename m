From: rabin@rab.in (Rabin Vincent)
Date: Sun, 20 Dec 2015 16:29:39 +0100
Subject: [PATCH V7 02/24] coresight: associating path with session rather
 than tracer
In-Reply-To: <1450472361-426-3-git-send-email-mathieu.poirier@linaro.org>
References: <1450472361-426-1-git-send-email-mathieu.poirier@linaro.org>
 <1450472361-426-3-git-send-email-mathieu.poirier@linaro.org>
Message-ID: <20151220152939.GA11552@debian>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Dec 18, 2015 at 01:58:58PM -0700, Mathieu Poirier wrote:
> When using the Coresight framework from the sysFS interface a
> tracer is always handling a single session and as such, a path
> can be associated with a tracer.  But when supporting multiple
> session per tracer there is no guarantee that sessions will always
> have the same path from source to sink.
> 
> This patch is removing the automatic association between path and
> tracers.  The building of a path and enablement of the components
> in the path are decoupled, allowing for the association of a path
> with a session rather than a tracer.

This patch introduces a use-after-free/double kfree() if the sink is
disabled after the source.

With this command sequence:

# echo 1 > /sys/bus/coresight/devices/54162000.etb/enable_sink 
# echo 1 > /sys/bus/coresight/devices/5414c000.ptm/enable_source 
...
# echo 0 > /sys/bus/coresight/devices/54162000.etb/enable_sink 
# echo 0 > /sys/bus/coresight/devices/5414c000.ptm/enable_source 

Before these patches, we get these messages while disabling:

[  165.822326] coresight-etm3x 5414c000.ptm: ETM tracing disabled
[  165.828491] coresight 5414c000.ptm: releasing path(s) failed

After these patches, we get this (with SLUB debugging enabled):

=============================================================================
BUG kmalloc-512 (Not tainted): Invalid object pointer 0xed60e164
-----------------------------------------------------------------------------

Disabling lock debugging due to kernel taint
INFO: Slab 0xeebac180 objects=23 used=23 fp=0x  (null) flags=0x4081
CPU: 0 PID: 856 Comm: sh Tainted: G    B           4.4.0-rc5-00224-ge461459-dirty #168
Hardware name: Generic OMAP4 (Flattened Device Tree)
Backtrace: 
[<c00154d4>] (dump_backtrace) from [<c00156d0>] (show_stack+0x18/0x1c)
 r7:00000001 r6:eebac180 r5:c07ae71c r4:00000000
[<c00156b8>] (show_stack) from [<c027e69c>] (dump_stack+0x98/0xc0)
[<c027e604>] (dump_stack) from [<c014f018>] (slab_err+0x78/0x80)
 r5:ee0013c0 r4:eebac180
[<c014efa4>] (slab_err) from [<c0153880>] (free_debug_processing+0x234/0x34c)
 r3:ed60e164 r2:c068d484
 r5:ee0013c0 r4:ed60e164
[<c015364c>] (free_debug_processing) from [<c0153c34>] (__slab_free+0x29c/0x428)
 r10:ee0013c0 r9:00000000 r8:20000013 r7:c041a5f4 r6:ed60e164 r5:00010d00
 r4:eebac180
[<c0153998>] (__slab_free) from [<c0154770>] (kfree+0x2dc/0x2f4)
 r10:eda29f80 r9:00000000 r8:20000013 r7:c041a5f4 r6:ed60e164 r5:eebac180
 r4:ee0013c0
[<c0154494>] (kfree) from [<c041a5f4>] (etm_disable+0xf8/0x148)
 r10:eda29f80 r9:00000000 r8:ed7ba500 r7:00000000 r6:ed60e120 r5:00000001
 r4:ed60e110
[<c041a4fc>] (etm_disable) from [<c0415e64>] (coresight_disable+0xbc/0x100)
 r7:00000000 r6:c0771150 r5:c076c900 r4:ed662600
[<c0415da8>] (coresight_disable) from [<c0415ef0>] (enable_source_store+0x48/0x68)
 r9:ed67ec8c r8:ed7d7900 r7:00000000 r6:ed7d7900 r5:00000002 r4:ed662620
[<c0415ea8>] (enable_source_store) from [<c030b37c>] (dev_attr_store+0x20/0x2c)
 r5:ed67ec80 r4:c0415ea8
[<c030b35c>] (dev_attr_store) from [<c01d55d8>] (sysfs_kf_write+0x50/0x54)
 r5:ed67ec80 r4:c030b35c
[<c01d5588>] (sysfs_kf_write) from [<c01d4b98>] (kernfs_fop_write+0xc4/0x1c0)
 r7:00000000 r6:00000000 r5:00000002 r4:ed67ec80
[<c01d4ad4>] (kernfs_fop_write) from [<c015b60c>] (__vfs_write+0x34/0xe4)
 r10:00000000 r9:eda28000 r8:c0010964 r7:eda29f80 r6:00000002 r5:c01d4ad4
 r4:ed811180
[<c015b5d8>] (__vfs_write) from [<c015bf38>] (vfs_write+0x98/0x174)
 r9:eda28000 r8:c0010964 r7:eda29f80 r6:000a9e40 r5:00000002 r4:ed811180
[<c015bea0>] (vfs_write) from [<c015c7a8>] (SyS_write+0x4c/0xa8)
 r8:c0010964 r7:00000002 r6:000a9e40 r5:ed811180 r4:ed811180
[<c015c75c>] (SyS_write) from [<c00107c0>] (ret_fast_syscall+0x0/0x1c)
 r7:00000004 r6:00000001 r5:000a9e40 r4:00000002
FIX kmalloc-512: Object at 0xed60e164 not freed
