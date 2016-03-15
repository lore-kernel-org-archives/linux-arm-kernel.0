From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 15 Mar 2016 22:31:17 +0100
Subject: [PATCH] ARM: pxa/raumfeld: use PROPERTY_ENTRY_INTEGER to define props
Message-ID: <1458077493-350816-1-git-send-email-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

gcc-6.0 notices that the use of the property_entry in this file that
was recently introduced cannot work right, as we initialize the wrong
field:

raumfeld.c:387:3: error: the address of 'raumfeld_rotary_encoder_steps' will always evaluate as 'true' [-Werror=address]
   DEV_PROP_U32, 1, &raumfeld_rotary_encoder_steps, },
   ^~~~~~~~~~~~
raumfeld.c:389:3: error: the address of 'raumfeld_rotary_encoder_axis' will always evaluate as 'true' [-Werror=address]
   DEV_PROP_U32, 1, &raumfeld_rotary_encoder_axis, },
   ^~~~~~~~~~~~
raumfeld.c:391:3: error: the address of 'raumfeld_rotary_encoder_relative_axis' will always evaluate as 'true' [-Werror=address]
   DEV_PROP_U32, 1, &raumfeld_rotary_encoder_relative_axis, },
   ^~~~~~~~~~~~

The problem appears to stem from relying on an old definition of
'struct property', but it has changed several times since the code
could have last been correct.

This changes the code to use the PROPERTY_ENTRY_INTEGER() macro instead,
which works fine for the current definition and is a safer way of doing
the initialization.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Fixes: a9e340dce3c3 ("Input: rotary_encoder - move away from platform data structure")
---

The broken patch is currently in the input-next tree, please apply this
fixup on top.

 arch/arm/mach-pxa/raumfeld.c | 15 ++++-----------
 1 file changed, 4 insertions(+), 11 deletions(-)

diff --git a/arch/arm/mach-pxa/raumfeld.c b/arch/arm/mach-pxa/raumfeld.c
index 16ffd01daff1..5a941bd3dbed 100644
--- a/arch/arm/mach-pxa/raumfeld.c
+++ b/arch/arm/mach-pxa/raumfeld.c
@@ -378,18 +378,11 @@ static struct gpiod_lookup_table raumfeld_rotary_gpios_table = {
 	},
 };
 
-static u32 raumfeld_rotary_encoder_steps = 24;
-static u32 raumfeld_rotary_encoder_axis = REL_X;
-static u32 raumfeld_rotary_encoder_relative_axis = 1;
-
 static struct property_entry raumfeld_rotary_properties[] = {
-	{ "rotary-encoder,steps-per-period",
-		DEV_PROP_U32, 1, &raumfeld_rotary_encoder_steps, },
-	{ "linux,axis",
-		DEV_PROP_U32, 1, &raumfeld_rotary_encoder_axis, },
-	{ "rotary-encoder,relative_axis",
-		DEV_PROP_U32, 1, &raumfeld_rotary_encoder_relative_axis, },
-	{ NULL }
+	PROPERTY_ENTRY_INTEGER("rotary-encoder,steps-per-period", u32, 24),
+	PROPERTY_ENTRY_INTEGER("linux,axis",			  u32, REL_X),
+	PROPERTY_ENTRY_INTEGER("rotary-encoder,relative_axis",	  u32, 1),
+	{ },
 };
 
 static struct property_set raumfeld_rotary_property_set = {
-- 
2.7.0
