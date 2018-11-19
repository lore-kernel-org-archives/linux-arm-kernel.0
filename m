From: stefanb@linux.ibm.com (Stefan Berger)
Date: Mon, 19 Nov 2018 09:23:03 -0500
Subject: [PATCH v9 00/17] Removed nested TPM operations
In-Reply-To: <20181118124753.18613-1-jarkko.sakkinen@linux.intel.com>
References: <20181118124753.18613-1-jarkko.sakkinen@linux.intel.com>
Message-ID: <1393743e-7c54-4a83-ba2a-779a3a8a31e3@linux.ibm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/18/18 7:47 AM, Jarkko Sakkinen wrote:
> [was Detach TPM space code out of the tpm_transmit() flow but the scope
>   expanded a bit.]
>
> Make the changes necessary to detach TPM space code and TPM activation
> code out of the tpm_transmit() flow because of both of these can cause
> nested tpm_transmit() calls. The nesteds calls make the whole flow hard
> to maintain, and thus, it is better to just fix things now before this
> turns into a bigger mess.

Tested this series with the vtpm proxy test cases:


Tested-by: Stefan Berger <stefanb@linux.ibm.com>


>
> v9:
> * Fixed again tpm_try_get_ops().
> * Added missing reviewed-by's.
>
> v8:
> * Re-add the check for ret < 0 after calling tpm_try_transmit() that
>    was dropped by mistake while moving code.
> * Fix error fallback for tpm_try_get_ops() when tpm_chip_start()
>    fails.
>
> v7:
> *  Reorganize series so that more trivial and self-contained changes are
>     in the head.
>
> v6:
> * When tpm_validate_commmand() was moved to tpm2-space.c, the struct for
>    the TPM header was incorrectly declared as struct tpm_input_header.
> * Fix return value in tpm_validate_command().
>
> v5:
> * Add the missing rev's from Stefan Berger.
>
> v4:
> * Return 0 from pcrs_show() when tpm1_pcr_read() fails.
> * Fix error handling flow in tpm_try_transmit().
> * Replace struct tpm_input_header and struct tpm_output_header with
>    struct tpm_header.
>
> v3:
> * Encapsulate power gating code to tpm_chip_start() and tpm_chip_stop().
> * Move TPM power gating code and locking to tpm_try_get_ops() and
>    tpm_put_ops().
> * Call power gating code directly in tpm_chip_register() and
>    tpm2_del_space().
>
> v2:
> * Print tpm2_commit_space() error inside tpm2_commit_space()
> * Error code was not printed when recv() callback failed. It is
>    fixed in this version.
> * Added a patch that removes @space from tpm_transmit().
> * Fixed a regression in earlier series. Forgot to amend the change
>    from the staging area that renames NESTED to UNLOCKED in tpm2-space.c.
>
> Jarkko Sakkinen (17):
>    tpm: use tpm_buf in tpm_transmit_cmd() as the IO parameter
>    tpm: fix invalid return value in pubek_show()
>    tpm: return 0 from pcrs_show() when tpm1_pcr_read() fails
>    tpm: print tpm2_commit_space() error inside tpm2_commit_space()
>    tpm: declare struct tpm_header
>    tpm: access command header through struct in tpm_try_transmit()
>    tpm: encapsulate tpm_dev_transmit()
>    tpm: call tpm2_flush_space() on error in tpm_try_transmit()
>    tpm: clean up tpm_try_transmit() error handling flow
>    tpm: move tpm_validate_commmand() to tpm2-space.c
>    tpm: move TPM space code out of tpm_transmit()
>    tpm: remove @space from tpm_transmit()
>    tpm: use tpm_try_get_ops() in tpm-sysfs.c.
>    tpm: remove TPM_TRANSMIT_UNLOCKED flag
>    tpm: introduce tpm_chip_start() and tpm_chip_stop()
>    tpm: take TPM chip power gating out of tpm_transmit()
>    tpm: remove @flags from tpm_transmit()
>
>   drivers/char/tpm/tpm-chip.c       | 109 ++++++++++++
>   drivers/char/tpm/tpm-dev-common.c |  45 ++++-
>   drivers/char/tpm/tpm-interface.c  | 264 ++++++------------------------
>   drivers/char/tpm/tpm-sysfs.c      | 138 ++++++++++------
>   drivers/char/tpm/tpm.h            |  64 +++-----
>   drivers/char/tpm/tpm1-cmd.c       |  28 +---
>   drivers/char/tpm/tpm2-cmd.c       |  72 +++-----
>   drivers/char/tpm/tpm2-space.c     |  93 ++++++++---
>   drivers/char/tpm/tpm_i2c_atmel.c  |   5 +-
>   drivers/char/tpm/tpm_vtpm_proxy.c |  12 +-
>   drivers/char/tpm/xen-tpmfront.c   |   2 +-
>   11 files changed, 410 insertions(+), 422 deletions(-)
>
