From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 15 Feb 2013 18:00:36 +0000
Subject: randconfig errors
In-Reply-To: <511E6FA4.2000709@gmail.com>
References: <511E6FA4.2000709@gmail.com>
Message-ID: <201302151800.36948.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 15 February 2013, Rob Herring wrote:
> Errors from randconfig builds restricted to multi-platform configs on
> the current linux-next. I know I've seen a fix on the first one from
> Arnd, but have not investigated any of these.

I have seen some of these before with the allyesconfig builds.
Investigating randconfig is on my list for next week.

> /var/lib/jenkins/jobs/linux-randconfig/workspace/arch/arm/kernel/arch_timer.c:55:11: error: 'ENXIO' undeclared (first use in this function)
> /var/lib/jenkins/jobs/linux-randconfig/workspace/arch/arm/mach-imx/mach-imx6q.c:248:2: error: implicit declaration of function 'of_init_opp_table' [-Werror=implicit-function-declaration]
> /var/lib/jenkins/jobs/linux-randconfig/workspace/arch/arm/mach-omap2/omap_hwmod_reset.c:47:11: error: 'EINVAL' undeclared (first use in this function)
> /var/lib/jenkins/jobs/linux-randconfig/workspace/arch/arm/mach-omap2/soc.h:118:19: error: redefinition of 'soc_is_omap'
> /var/lib/jenkins/jobs/linux-randconfig/workspace/arch/arm/mach-omap2/soc.h:184:1: error: redefinition of 'is_omap24xx'
> /var/lib/jenkins/jobs/linux-randconfig/workspace/arch/arm/mach-omap2/soc.h:185:1: error: redefinition of 'is_omap34xx'
> /var/lib/jenkins/jobs/linux-randconfig/workspace/arch/arm/mach-omap2/soc.h:186:1: error: redefinition of 'is_omap44xx'
> /var/lib/jenkins/jobs/linux-randconfig/workspace/arch/arm/mach-omap2/soc.h:187:1: error: redefinition of 'is_am35xx'

Patch is queued in arm-soc now.

> /var/lib/jenkins/jobs/linux-randconfig/workspace/drivers/clk/clk-vt8500.c:160:24: error: 'prate' undeclared (first use in this function)

I've seen this one with allyesconfig but have not tried to make a fix

> /var/lib/jenkins/jobs/linux-randconfig/workspace/drivers/crypto/omap-aes.c:363:2: error: implicit declaration of function 'dma_request_slave_channel_compat' [-Werror=implicit-function-declaration]
> /var/lib/jenkins/jobs/linux-randconfig/workspace/drivers/crypto/omap-sham.c:1707:2: error: implicit declaration of function 'dma_request_slave_channel_compat' [-Werror=implicit-function-declaration]

These are waiting for a patch from Matt Porter, "[PATCH v7 07/10] dmaengine: add
dma_request_slave_channel_compat()". Matt, what is your plan for this? I assume
it's too late to get the entire series into 3.9, but you have Vinod's Ack on this
one, and it should probably get merged early on because of the other subsystems
that are not tracking their dependencies ;-)

> /var/lib/jenkins/jobs/linux-randconfig/workspace/drivers/gpu/drm/drm_pci.c:485:2: error: implicit declaration of function 'pcie_capability_read_dword' [-Werror=implicit-function-declaration]

Should be fixed in today's -next.

> /var/lib/jenkins/jobs/linux-randconfig/workspace/drivers/iio/common/st_sensors/st_sensors_trigger.c:21:5: error: redefinition of 'st_sensors_allocate_trigger'
> /var/lib/jenkins/jobs/linux-randconfig/workspace/drivers/iio/common/st_sensors/st_sensors_trigger.c:65:6: error: redefinition of 'st_sensors_deallocate_trigger'
> /var/lib/jenkins/jobs/linux-randconfig/workspace/drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c:176:3: error: implicit declaration of function 'iio_push_to_buffers' [-Werror=implicit-function-declaration]
> /var/lib/jenkins/jobs/linux-randconfig/workspace/drivers/iio/imu/inv_mpu6050/inv_mpu_trigger.c:106:36: error: dereferencing pointer to incomplete type
> /var/lib/jenkins/jobs/linux-randconfig/workspace/drivers/iio/imu/inv_mpu6050/inv_mpu_trigger.c:109:21: error: variable 'inv_mpu_trigger_ops' has initializer but incomplete type
> /var/lib/jenkins/jobs/linux-randconfig/workspace/drivers/iio/imu/inv_mpu6050/inv_mpu_trigger.c:110:2: error: unknown field 'owner' specified in initializer
> /var/lib/jenkins/jobs/linux-randconfig/workspace/drivers/iio/imu/inv_mpu6050/inv_mpu_trigger.c:111:2: error: unknown field 'set_trigger_state' specified in initializer
> /var/lib/jenkins/jobs/linux-randconfig/workspace/drivers/iio/imu/inv_mpu6050/inv_mpu_trigger.c:119:2: error: implicit declaration of function 'iio_trigger_alloc' [-Werror=implicit-function-declaration]
> /var/lib/jenkins/jobs/linux-randconfig/workspace/drivers/iio/imu/inv_mpu6050/inv_mpu_trigger.c:126:38: error: 'iio_trigger_generic_data_rdy_poll' undeclared (first use in this function)
> /var/lib/jenkins/jobs/linux-randconfig/workspace/drivers/iio/imu/inv_mpu6050/inv_mpu_trigger.c:132:10: error: dereferencing pointer to incomplete type
> /var/lib/jenkins/jobs/linux-randconfig/workspace/drivers/iio/imu/inv_mpu6050/inv_mpu_trigger.c:133:10: error: dereferencing pointer to incomplete type
> /var/lib/jenkins/jobs/linux-randconfig/workspace/drivers/iio/imu/inv_mpu6050/inv_mpu_trigger.c:134:10: error: dereferencing pointer to incomplete type
> /var/lib/jenkins/jobs/linux-randconfig/workspace/drivers/iio/imu/inv_mpu6050/inv_mpu_trigger.c:135:2: error: implicit declaration of function 'iio_trigger_register' [-Werror=implicit-function-declaration]
> /var/lib/jenkins/jobs/linux-randconfig/workspace/drivers/iio/imu/inv_mpu6050/inv_mpu_trigger.c:145:2: error: implicit declaration of function 'iio_trigger_free' [-Werror=implicit-function-declaration]
> /var/lib/jenkins/jobs/linux-randconfig/workspace/drivers/iio/imu/inv_mpu6050/inv_mpu_trigger.c:152:2: error: implicit declaration of function 'iio_trigger_unregister' [-Werror=implicit-function-declaration]
> /var/lib/jenkins/jobs/linux-randconfig/workspace/drivers/iio/industrialio-triggered-buffer.c:20:16: error: 'iio_sw_buffer_preenable' undeclared here (not in a function)

I have not seen any of these so far.

> /var/lib/jenkins/jobs/linux-randconfig/workspace/drivers/media/platform/davinci/vpss.c:28:27: fatal error: mach/hardware.h: No such file or directory

patch sent, waiting for Mauro

> /var/lib/jenkins/jobs/linux-randconfig/workspace/drivers/remoteproc/omap_remoteproc.c:31:26: fatal error: plat/mailbox.h: No such file or directory

Fixed in arm-soc today

> /var/lib/jenkins/jobs/linux-randconfig/workspace/drivers/tty/serial/8250/8250.c:2712:47: error: 'CONFIG_SERIAL_8250_NR_UARTS' undeclared here (not in a function)
> /var/lib/jenkins/jobs/linux-randconfig/workspace/drivers/tty/serial/8250/8250.c:2971:20: error: negative width in bit-field '<anonymous>'
> /var/lib/jenkins/jobs/linux-randconfig/workspace/drivers/tty/serial/8250/8250.c:57:32: error: 'CONFIG_SERIAL_8250_RUNTIME_UARTS' undeclared here (not in a function)
> /var/lib/jenkins/jobs/linux-randconfig/workspace/drivers/tty/serial/omap-serial.c:1185:14: error: 'struct uart_port' has no member named 'sysrq'

Haven't seen these ones.

> /var/lib/jenkins/jobs/linux-randconfig/workspace/drivers/usb/host/uhci-hcd.c:857:2: error: #error "missing bus glue for uhci-hcd"

I have a plan to fix this, but not patch.

> /var/lib/jenkins/jobs/linux-randconfig/workspace/drivers/video/omap2/dss/dss.c:572:20: error: 'CONFIG_OMAP2_DSS_MIN_FCK_PER_PCK' undeclared (first use in this function)

This is already broken in v3.8-rc7 and earlier, I hope the fix makes it into 3.8.

> /var/lib/jenkins/jobs/linux-randconfig/workspace/include/linux/kvm_host.h:333:34: error: 'KVM_USER_MEM_SLOTS' undeclared here (not in a function)
> /var/lib/jenkins/jobs/linux-randconfig/workspace/security/integrity/ima/ima_policy.c:538:4: error: implicit declaration of function 'part_pack_uuid' [-Werror=implicit-function-declaration]

I have not seen these two.

Thanks for the report.

	Arnd
