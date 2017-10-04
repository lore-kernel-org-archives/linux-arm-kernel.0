From: pure.logic@nexus-software.ie (Bryan O'Donoghue)
Date: Wed,  4 Oct 2017 23:25:14 +0100
Subject: [RESEND][PATCH 0/7] Fix i.MX7D OCOTP write support
Message-ID: <1507155921-824-1-git-send-email-pure.logic@nexus-software.ie>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

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

 drivers/nvmem/imx-ocotp.c | 191 +++++++++++++++++++++++++++++++++++++---------
 1 file changed, 156 insertions(+), 35 deletions(-)

-- 
2.7.4
