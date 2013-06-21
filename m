From: gsi@denx.de (Gerhard Sittig)
Date: Fri, 21 Jun 2013 20:09:48 +0200
Subject: [PATCH v1 02/12] input: matrix-keymap: func call coding style nit
In-Reply-To: <1371838198-7327-1-git-send-email-gsi@denx.de>
References: <1371838198-7327-1-git-send-email-gsi@denx.de>
Message-ID: <1371838198-7327-3-git-send-email-gsi@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

make the matrix_keypad_map_key() routine return an error code
instead of boolean, as its name suggests an action and not a query

Signed-off-by: Gerhard Sittig <gsi@denx.de>
---
 drivers/input/matrix-keymap.c |   19 ++++++++++---------
 1 file changed, 10 insertions(+), 9 deletions(-)

diff --git a/drivers/input/matrix-keymap.c b/drivers/input/matrix-keymap.c
index 08b61f5..b7091f2 100644
--- a/drivers/input/matrix-keymap.c
+++ b/drivers/input/matrix-keymap.c
@@ -27,9 +27,10 @@
 #include <linux/module.h>
 #include <linux/input/matrix_keypad.h>
 
-static bool matrix_keypad_map_key(struct input_dev *input_dev,
-				  unsigned int rows, unsigned int cols,
-				  unsigned int row_shift, unsigned int key)
+/* translates packed row/col/code specs to the corresponding keycode[] item */
+static int matrix_keypad_map_key(struct input_dev *input_dev,
+				 unsigned int rows, unsigned int cols,
+				 unsigned int row_shift, unsigned int key)
 {
 	unsigned short *keymap = input_dev->keycode;
 	unsigned int row = KEY_ROW(key);
@@ -40,13 +41,13 @@ static bool matrix_keypad_map_key(struct input_dev *input_dev,
 		dev_err(input_dev->dev.parent,
 			"%s: invalid keymap entry 0x%x (row: %d, col: %d, rows: %d, cols: %d)\n",
 			__func__, key, row, col, rows, cols);
-		return false;
+		return -ERANGE;
 	}
 
 	keymap[MATRIX_SCAN_CODE(row, col, row_shift)] = code;
 	__set_bit(code, input_dev->keybit);
 
-	return true;
+	return 0;
 }
 
 #ifdef CONFIG_OF
@@ -109,8 +110,8 @@ static int matrix_keypad_parse_of_keymap(const char *propname,
 	for (i = 0; i < size; i++) {
 		unsigned int key = be32_to_cpup(prop + i);
 
-		if (!matrix_keypad_map_key(input_dev, rows, cols,
-					   row_shift, key))
+		if (matrix_keypad_map_key(input_dev, rows, cols,
+					  row_shift, key) != 0)
 			return -EINVAL;
 	}
 
@@ -187,8 +188,8 @@ int matrix_keypad_build_keymap(const struct matrix_keymap_data *keymap_data,
 		for (i = 0; i < keymap_data->keymap_size; i++) {
 			unsigned int key = keymap_data->keymap[i];
 
-			if (!matrix_keypad_map_key(input_dev, rows, cols,
-						   row_shift, key))
+			if (matrix_keypad_map_key(input_dev, rows, cols,
+						  row_shift, key) != 0)
 				return -EINVAL;
 		}
 	} else {
-- 
1.7.10.4
