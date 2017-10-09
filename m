From: pure.logic@nexus-software.ie (Bryan O'Donoghue)
Date: Mon,  9 Oct 2017 15:11:45 +0100
Subject: [PATCH v3 0/7] Fix i.MX7D OCOTP write support
Message-ID: <1507558312-20580-1-git-send-email-pure.logic@nexus-software.ie>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

V3:
- Fix compile bug caused by a rebase typo - kbuild test robot

V2:
- Added Reviewed-by and Acked-by as indicated by Philipp
- octp_params -> ocotp_params Philipp Zabel
- Added whitespace to aggregate initaliser - Philipp Zabel
- Dropped (void*) cast to data - Philipp Zabel
- Made use of of_device_get_match_data - Philipp Zabel
- Got rid of params->banked - Philipp Zabel
- Changed regs_per_bank to bank_address_words
  makes the intent of the parameter clearer - Bryan O'Donoghue

V1:
(Resend: I may have missed Philip Zabel on the first send - apologies if
that is the case Philip.)

The current OCOTP driver added support for i.MX7 read access and then added
support for i.MX6 write access. Between the two commits the fact that the
added write routine was only appropriate for i.MX6 was missed.

As a result its certain that attempting to write i.MX7 OTP fuses on Linux
would fail as the destination address on i.MX7 is different to i.MX6.

Without the update to the i.MX7 setup and hold timings it's not clear that
a write operation would actually do any writing which means the bad
addressing on i.MX7 might not actually destroy the wrong OTP fuses, it
probably would just fail to do anything, understandably I haven't
experimented with knowingly bad values for one-time-programmable fuses.

This series fixes the gap by:

1. Switching off OTP writing for i.MX7
2. Adding in support for the i.MX7 way of doing things
3. Switching OTP write support back on for i.MX7

There's an additional small fix for the naming of the module then to
indicate it works for i.MX7 as well as for i.MX6.

Bryan O'Donoghue (7):
  nvmem: imx-ocotp: Restrict OTP write to IMX6 processors
  nvmem: imx-ocotp: Pass parameters via a struct
  nvmem: imx-ocotp: Add support for banked OTP addressing
  nvmem: imx-ocotp: Move i.MX6 write clock setup to dedicated function
  nvmem: imx-ocotp: Add i.MX7D timing write clock setup support
  nvmem: imx-ocotp: Enable i.MX7D OTP write support
  nvmem: imx-ocotp: Update module description

 drivers/nvmem/imx-ocotp.c | 182 +++++++++++++++++++++++++++++++++++++---------
 1 file changed, 147 insertions(+), 35 deletions(-)

-- 
2.7.4
