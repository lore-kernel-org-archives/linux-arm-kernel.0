From: lkp@intel.com (kbuild test robot)
Date: Thu, 9 Nov 2017 19:13:32 +0800
Subject: [PATCH v5 05/12] arm: vdso: Add support for CLOCK_MONOTONIC_RAW
In-Reply-To: <20171106210211.94955-1-salyzyn@android.com>
References: <20171106210211.94955-1-salyzyn@android.com>
Message-ID: <201711091848.JFCOx5ZH%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mark,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on linus/master]
[also build test ERROR on v4.14-rc8]
[cannot apply to next-20171109]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Mark-Salyzyn/arm-vdso-rename-vdso_datapage-variables/20171109-160311
config: arm-sunxi_defconfig (attached as .config)
compiler: arm-linux-gnueabi-gcc (Debian 6.1.1-9) 6.1.1 20160705
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        make.cross ARCH=arm 

All errors (new ones prefixed by >>):

   arch/arm/kernel/vdso.c: In function 'update_vsyscall':
>> arch/arm/kernel/vdso.c:338:32: error: 'struct timekeeper' has no member named 'raw_time'; did you mean 'raw_sec'?
      vdso_data->raw_time_sec  = tk->raw_time.tv_sec;
                                   ^~
   arch/arm/kernel/vdso.c:339:33: error: 'struct timekeeper' has no member named 'raw_time'; did you mean 'raw_sec'?
      vdso_data->raw_time_nsec = (tk->raw_time.tv_nsec <<
                                    ^~

vim +338 arch/arm/kernel/vdso.c

   297	
   298	/**
   299	 * update_vsyscall - update the vdso data page
   300	 *
   301	 * Increment the sequence counter, making it odd, indicating to
   302	 * userspace that an update is in progress.  Update the fields used
   303	 * for coarse clocks and, if the architected system timer is in use,
   304	 * the fields used for high precision clocks.  Increment the sequence
   305	 * counter again, making it even, indicating to userspace that the
   306	 * update is finished.
   307	 *
   308	 * Userspace is expected to sample tb_seq_count before reading any other
   309	 * fields from the data page.  If tb_seq_count is odd, userspace is
   310	 * expected to wait until it becomes even.  After copying data from
   311	 * the page, userspace must sample tb_seq_count again; if it has changed
   312	 * from its previous value, userspace must retry the whole sequence.
   313	 *
   314	 * Calls to update_vsyscall are serialized by the timekeeping core.
   315	 */
   316	void update_vsyscall(struct timekeeper *tk)
   317	{
   318		struct timespec64 *wtm = &tk->wall_to_monotonic;
   319	
   320		if (!cntvct_ok) {
   321			/* The entry points have been zeroed, so there is no
   322			 * point in updating the data page.
   323			 */
   324			return;
   325		}
   326	
   327		vdso_write_begin(vdso_data);
   328	
   329		vdso_data->use_syscall			= !tk_is_cntvct(tk);
   330		vdso_data->xtime_coarse_sec		= tk->xtime_sec;
   331		vdso_data->xtime_coarse_nsec		= (u32)(tk->tkr_mono.xtime_nsec >>
   332								tk->tkr_mono.shift);
   333		vdso_data->wtm_clock_sec		= wtm->tv_sec;
   334		vdso_data->wtm_clock_nsec		= wtm->tv_nsec;
   335	
   336		if (!vdso_data->use_syscall) {
   337			vdso_data->cs_cycle_last	= tk->tkr_mono.cycle_last;
 > 338			vdso_data->raw_time_sec		= tk->raw_time.tv_sec;
   339			vdso_data->raw_time_nsec	= (tk->raw_time.tv_nsec <<
   340							   tk->tkr_raw.shift) +
   341							  tk->tkr_raw.xtime_nsec;
   342			vdso_data->xtime_clock_sec	= tk->xtime_sec;
   343			vdso_data->xtime_clock_snsec	= tk->tkr_mono.xtime_nsec;
   344			vdso_data->cs_mono_mult		= tk->tkr_mono.mult;
   345			vdso_data->cs_raw_mult		= tk->tkr_raw.mult;
   346			/* tkr_mono.shift == tkr_raw.shift */
   347			vdso_data->cs_shift		= tk->tkr_mono.shift;
   348			vdso_data->cs_mask		= tk->tkr_mono.mask;
   349		}
   350	
   351		vdso_write_end(vdso_data);
   352	
   353		flush_dcache_page(virt_to_page(vdso_data));
   354	}
   355	

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 23021 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20171109/25e5ed4a/attachment-0001.gz>
