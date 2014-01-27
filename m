From: chao.xie@marvell.com (Chao Xie)
Date: Mon, 27 Jan 2014 12:41:37 +0800
Subject: [PATCH] input: pxa27x-keypad: bug fix of getting scan code
Message-ID: <1390797697-29217-1-git-send-email-chao.xie@marvell.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Chao Xie <chao.xie@marvell.com>

The rows of pxa27x-keypad used by each boards are not fixed.
So in the driver, it will get the rows from DT and register
the keymap as:
matrix_keypad_build_keymap(keymap_data, NULL,
                           pdata->matrix_key_rows,
                           pdata->matrix_key_cols,
                           keypad->keycodes, input_dev);

But the scan code is gotten as
MATRIX_SCAN_CODE(row, col, MATRIX_ROW_SHIFT);
It is not correct. Fix it as
MATRIX_SCAN_CODE(row, col, keypad->row_shift);

row_shift is calculated from pdata->matrix_key_rows.

Signed-off-by: Chao Xie <chao.xie@marvell.com>
---
 drivers/input/keyboard/pxa27x_keypad.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/input/keyboard/pxa27x_keypad.c b/drivers/input/keyboard/pxa27x_keypad.c
index d8241ba..8da3eb0 100644
--- a/drivers/input/keyboard/pxa27x_keypad.c
+++ b/drivers/input/keyboard/pxa27x_keypad.c
@@ -113,6 +113,7 @@ struct pxa27x_keypad {
 
 	/* state row bits of each column scan */
 	uint32_t matrix_key_state[MAX_MATRIX_KEY_COLS];
+	uint32_t row_shift;
 	uint32_t direct_key_state;
 
 	unsigned int direct_key_mask;
@@ -139,6 +140,7 @@ static int pxa27x_keypad_matrix_key_parse_dt(struct pxa27x_keypad *keypad,
 	pdata->matrix_key_rows = rows;
 	pdata->matrix_key_cols = cols;
 
+	keypad->row_shift = get_count_order(pdata->matrix_key_cols);
 	error = matrix_keypad_build_keymap(NULL, NULL,
 					   pdata->matrix_key_rows,
 					   pdata->matrix_key_cols,
@@ -359,6 +361,7 @@ static int pxa27x_keypad_build_keycode(struct pxa27x_keypad *keypad)
 	if (error)
 		return error;
 
+	keypad->row_shift = get_count_order(pdata->matrix_key_cols);
 	/*
 	 * The keycodes may not only include matrix keys but also the direct
 	 * or rotary keys.
@@ -467,7 +470,8 @@ scan:
 			if ((bits_changed & (1 << row)) == 0)
 				continue;
 
-			code = MATRIX_SCAN_CODE(row, col, MATRIX_ROW_SHIFT);
+			code = MATRIX_SCAN_CODE(row, col, keypad->row_shift);
+
 			input_event(input_dev, EV_MSC, MSC_SCAN, code);
 			input_report_key(input_dev, keypad->keycodes[code],
 					 new_state[col] & (1 << row));
-- 
1.8.3.2
