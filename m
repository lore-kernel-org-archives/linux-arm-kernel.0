From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 20 Feb 2018 17:24:52 +0100
Subject: [PATCH 3/3] ARM: davinci: mark spi_board_info arrays as const
In-Reply-To: <20180220162519.1498223-1-arnd@arndb.de>
References: <20180220162519.1498223-1-arnd@arndb.de>
Message-ID: <20180220162519.1498223-3-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Building with LTO revealed that three spi_board_info arrays are marked
__initconst, but not const:

arch/arm/mach-davinci/board-dm365-evm.c: In function 'dm365_evm_init':
arch/arm/mach-davinci/board-dm365-evm.c:729:30: error: 'dm365_evm_spi_info' causes a section type conflict with 'dm646x_edma_device'
 static struct spi_board_info dm365_evm_spi_info[] __initconst = {
                              ^
arch/arm/mach-davinci/dm646x.c:603:42: note: 'dm646x_edma_device' was declared here
 static const struct platform_device_info dm646x_edma_device __initconst = {

This marks them const as well, as was originally intended.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm/mach-davinci/board-dm355-evm.c     | 2 +-
 arch/arm/mach-davinci/board-dm355-leopard.c | 2 +-
 arch/arm/mach-davinci/board-dm365-evm.c     | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-davinci/board-dm355-evm.c b/arch/arm/mach-davinci/board-dm355-evm.c
index e457f299cd44..d6b11907380c 100644
--- a/arch/arm/mach-davinci/board-dm355-evm.c
+++ b/arch/arm/mach-davinci/board-dm355-evm.c
@@ -368,7 +368,7 @@ static struct spi_eeprom at25640a = {
 	.flags		= EE_ADDR2,
 };
 
-static struct spi_board_info dm355_evm_spi_info[] __initconst = {
+static const struct spi_board_info dm355_evm_spi_info[] __initconst = {
 	{
 		.modalias	= "at25",
 		.platform_data	= &at25640a,
diff --git a/arch/arm/mach-davinci/board-dm355-leopard.c b/arch/arm/mach-davinci/board-dm355-leopard.c
index be997243447b..fad9a5611a5d 100644
--- a/arch/arm/mach-davinci/board-dm355-leopard.c
+++ b/arch/arm/mach-davinci/board-dm355-leopard.c
@@ -217,7 +217,7 @@ static struct spi_eeprom at25640a = {
 	.flags		= EE_ADDR2,
 };
 
-static struct spi_board_info dm355_leopard_spi_info[] __initconst = {
+static const struct spi_board_info dm355_leopard_spi_info[] __initconst = {
 	{
 		.modalias	= "at25",
 		.platform_data	= &at25640a,
diff --git a/arch/arm/mach-davinci/board-dm365-evm.c b/arch/arm/mach-davinci/board-dm365-evm.c
index e75741fb2c1d..e3780986d2a3 100644
--- a/arch/arm/mach-davinci/board-dm365-evm.c
+++ b/arch/arm/mach-davinci/board-dm365-evm.c
@@ -726,7 +726,7 @@ static struct spi_eeprom at25640 = {
 	.flags		= EE_ADDR2,
 };
 
-static struct spi_board_info dm365_evm_spi_info[] __initconst = {
+static const struct spi_board_info dm365_evm_spi_info[] __initconst = {
 	{
 		.modalias	= "at25",
 		.platform_data	= &at25640,
-- 
2.9.0
