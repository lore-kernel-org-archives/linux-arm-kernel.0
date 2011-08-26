From: kzjeef@gmail.com (Jiejing.Zhang )
Date: Fri, 26 Aug 2011 15:32:28 +0800
Subject: [PATCH 4/4] Do not call flush_cache_user_range with mmap_sem held
In-Reply-To: <1301924629.15819.42.camel@e102109-lin.cambridge.arm.com>
References: <1292302659-1863-1-git-send-email-john.stultz@linaro.org>
	<1292302659-1863-5-git-send-email-john.stultz@linaro.org>
	<20101214093002.GA18425@n2100.arm.linux.org.uk>
	<AANLkTim1Wspod2LnfVw7atzP921C6o7EiKRVqw9LeqhG@mail.gmail.com>
	<20101214190503.GB24303@n2100.arm.linux.org.uk>
	<AANLkTimw839TCrzY0X4n8_AcwwdT1kFxNQNNsFC9SRdb@mail.gmail.com>
	<BANLkTinmCNi3MgcZo5CJorpoLNxwMwhVOA@mail.gmail.com>
	<20110404133718.GC22480@n2100.arm.linux.org.uk>
	<1301924629.15819.42.camel@e102109-lin.cambridge.arm.com>
Message-ID: <CACrgxGB16ibPARkf8TN4S47vOZwm+W2pBJyEj=e+F0uFK5NjmA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Catalin, Russell,

I met this issue on our development board: iMX53 + 2.6.35.2 Kernel,
this is stack trace when the dead lock happens.

You can see the hung task are dead lock at __read_lock(), after I add
more debug message and dump the hung task's stack trace.

After apply this patch, the hung is gong.

This is the hung task's output:

Freezing of tasks failed after 20.01 seconds (7 tasks refusing to freeze):

InputDispatch D 80477548     0  2209   2108 0x00080001
[<80477548>] (schedule+0x2b0/0x334) from [<8047949c>] (__down_read+0x12c/0x140)
[<8047949c>] (__down_read+0x12c/0x140) from [<800b62a0>]
access_process_vm+0x3c/0x120)
[<800b62a0>] (access_process_vm+0x3c/0x120) from [<8010e528>]
proc_pid_cmdline+0x50/0xcc)
[<8010e528>] (proc_pid_cmdline+0x50/0xcc) from [<8010fafc>]
(proc_info_read+0x58/0xc4)
[<8010fafc>] (proc_info_read+0x58/0xc4) from [<800ce550>] (vfs_read+0xa8/0x150)
[<800ce550>] (vfs_read+0xa8/0x150) from [<800ce6a4>] (sys_read+0x3c/0x68)
[<800ce6a4>] (sys_read+0x3c/0x68) from [<8003af80>] (ret_fast_syscall+0x0/0x30)

android.brows D 80477548     0  2575   2108 0x00080001
[<80477548>] (schedule+0x2b0/0x334) from [<80479354>]
__down_write_nested+0x128/0x13c)
[<80479354>] (__down_write_nested+0x128/0x13c) from [<800bc62c>]
(sys_mprotect+0xac/0x1f0)
[<800bc62c>] (sys_mprotect+0xac/0x1f0) from [<8003af80>]
(ret_fast_syscall+0x0/0x30)

Binder Thread D 80477548     0  2585   2108 0x00080001
[<80477548>] (schedule+0x2b0/0x334) from
[<80479354>](__down_write_nested+0x128/0x13c)
[<80479354>] (__down_write_nested+0x128/0x13c) from [<800bc0d0>]
(sys_f+0x70/0xb8)
[<800bc0d0>] (sys_mmap_pgoff+0x70/0xb8) from [<8003af80>]
(ret_fast_syscall+0x0/0x30)

WebViewCoreTh D 80477548     0  2606   2108 0x00080001
[<80477548>] (schedule+0x2b0/0x334) from [<8047949c>] (__down_read+0x12c/0x140)
[<8047949c>] (__down_read+0x12c/0x140) from [<80040494>]
(do_page_fault+0x8c/0x1d4)
[<80040494>] (do_page_fault+0x8c/0x1d4) from [<8003a2c8>]
(do_DataAbort+0x34/0x94)
[<8003a2c8>] (do_DataAbort+0x34/0x94) from [<8003aa2c>] (__dabt_svc+0x4c/0x60)
Exception stack(0xdfffdec0 to 0xdfffdf08)
dec0: 3ace1000 3ace3000 00000040 0000003f 3ace2020 d4323db4 3ace0020 d4323d80
dee0: 00000000 dfffc000 fffffa30 68888714 d4444528 dfffdf08 8003e760 800430e8
df00: 80000013 ffffffff
[<8003aa2c>] (__dabt_svc+0x4c/0x60) from [<800430e8>]
(v7_coherent_kern_range+0x18/0x54)
[<800430e8>] (v7_coherent_kern_range+0x18/0x54) from [<8003e760>]
(arm_syscall+0x14c/0x230)
[<8003e760>] (arm_syscall+0x14c/0x230) from [<8003af80>]
(ret_fast_syscall+0x0/0x30)

WebViewCoreTh D 80477548     0  2610   2108 0x00080001
[<80477548>] (schedule+0x2b0/0x334) from [<80479354>]
(__down_write_nested+0x128/0x13c)
[<80479354>] (__down_write_nested+0x128/0x13c) from [<800bc62c>]
(sys_mprotect+0xac/0x1f0)
[<800bc62c>] (sys_mprotect+0xac/0x1f0) from [<8003af80>]
(ret_fast_syscall+0x0/0x30)

WebViewCoreTh D 80477548     0  2612   2108 0x00080001
[<80477548>] (schedule+0x2b0/0x334) from [<8047949c>] (__down_read+0x12c/0x140)
[<8047949c>] (__down_read+0x12c/0x140) from [<80040494>]
(do_page_fault+0x8c/0x1d4)
[<80040494>] (do_page_fault+0x8c/0x1d4) from [<8003a234>]
(do_PrefetchAbort+0x34/0x94)
[<8003a234>] (do_PrefetchAbort+0x34/0x94) from [<8003af20>]
(ret_from_exception+0x0/0x10)
Exception stack(0xdfff3fb0 to 0xdfff3ff8)
3fa0:                                     39f46b18 39f46b18 6833ee01 39f46b18
3fc0: 39f46b18 001f7e20 001e2bd8 39f46b18 39f46b28 39f46b30 39f46b10 39f46b60
3fe0: 00000000 39f46af0 685d27b1 6833ee00 60000030 ffffffff
ps            D 80477548     0  2625   2623 0x00080001
[<80477548>] (schedule+0x2b0/0x334) from [<8047949c>] (__down_read+0x12c/0x140)
[<8047949c>] (__down_read+0x12c/0x140) from [<800b62a0>]
(access_process_vm+0x3c/0x120)
[<800b62a0>] (access_process_vm+0x3c/0x120) from [<8010e528>]
(proc_pid_cmdline+0x50/0xcc)
[<8010e528>] (proc_pid_cmdline+0x50/0xcc) from [<8010fafc>]
(proc_info_read+0x58/0xc4)
[<8010fafc>] (proc_info_read+0x58/0xc4) from [<800ce550>] (vfs_read+0xa8/0x150)
[<800ce550>] (vfs_read+0xa8/0x150) from [<800ce6a4>] (sys_read+0x3c/0x68)
[<800ce6a4>] (sys_read+0x3c/0x68) from [<8003af80>] (ret_fast_syscall+0x0/0x30)

Restarting tasks ... done.
suspend: exit suspend, ret = -16 (2000-01-01 00:48:46.107784876 UTC)
request_suspend_state: on (3->0) at 174620235627 (2000-01-01
00:48:46.127113876 UTC)
mxc_ipu mxc_ipu: Channel already disabled 9
mxc_ipu mxc_ipu: Channel already uninitialized 9
XXXX 1024 768 9997 910313298 960 80 20 6 10 16





Best regards,
Zhang Jiejing
