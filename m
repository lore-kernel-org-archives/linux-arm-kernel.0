From: gsi@denx.de (Gerhard Sittig)
Date: Fri, 21 Jun 2013 20:09:52 +0200
Subject: [PATCH v1 06/12] input: keypad-matrix: refactor matrix scan logic
In-Reply-To: <1371838198-7327-1-git-send-email-gsi@denx.de>
References: <1371838198-7327-1-git-send-email-gsi@denx.de>
Message-ID: <1371838198-7327-7-git-send-email-gsi@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

- factor out determination of all rows for a column into a separate routine
- only call input_sync() when input events were generated (in the future
  empty key code positions may get skipped, in the current implementation
  short bounces may trigger matrix scans while no change is seen)

Signed-off-by: Gerhard Sittig <gsi@denx.de>
---
 drivers/input/keyboard/matrix_keypad.c |   43 ++++++++++++++++++++++----------
 1 file changed, 30 insertions(+), 13 deletions(-)

diff --git a/drivers/input/keyboard/matrix_keypad.c b/drivers/input/keyboard/matrix_keypad.c
index 85e16a2..0b2599d 100644
--- a/drivers/input/keyboard/matrix_keypad.c
+++ b/drivers/input/keyboard/matrix_keypad.c
@@ -126,6 +126,28 @@ static bool row_asserted(const struct matrix_keypad_platform_data *pdata,
 }
 
 /*
+ * this routine fetches the status of all rows within the specified
+ * column, the column will get selected and deselected before and after
+ * sampling the row status
+ */
+static uint32_t sample_rows_for_col(struct matrix_keypad *keypad, int col)
+{
+	const struct matrix_keypad_platform_data *pdata;
+	uint32_t row_state;
+	int row;
+
+	pdata = keypad->pdata;
+
+	activate_col(pdata, col, true);
+	row_state = 0;
+	for (row = 0; row < pdata->num_row_gpios; row++)
+		row_state |= row_asserted(pdata, row) ? (1 << row) : 0;
+	activate_col(pdata, col, false);
+
+	return row_state;
+}
+
+/*
  * this routine enables IRQs after a keypad matrix scan has completed,
  * to have any subsequent change in the key press status trigger the ISR
  *
@@ -178,25 +200,18 @@ static void matrix_keypad_scan(struct work_struct *work)
 	const struct matrix_keypad_platform_data *pdata = keypad->pdata;
 	uint32_t new_state[MATRIX_MAX_COLS];
 	int row, col, code;
+	int has_events;
 
 	/* de-activate all columns before scanning the matrix */
 	activate_all_cols(pdata, false);
 
-	memset(new_state, 0, sizeof(new_state));
-
 	/* assert each column in turn and read back the row status */
-	for (col = 0; col < pdata->num_col_gpios; col++) {
-
-		activate_col(pdata, col, true);
-
-		for (row = 0; row < pdata->num_row_gpios; row++)
-			new_state[col] |=
-				row_asserted(pdata, row) ? (1 << row) : 0;
-
-		activate_col(pdata, col, false);
-	}
+	memset(new_state, 0, sizeof(new_state));
+	for (col = 0; col < pdata->num_col_gpios; col++)
+		new_state[col] = sample_rows_for_col(keypad, col);
 
 	/* detect changes and derive input events, update the snapshot */
+	has_events = 0;
 	for (col = 0; col < pdata->num_col_gpios; col++) {
 		uint32_t bits_changed;
 
@@ -222,9 +237,11 @@ static void matrix_keypad_scan(struct work_struct *work)
 			input_report_key(input_dev,
 					 keycodes[code],
 					 new_state[col] & (1 << row));
+			has_events++;
 		}
 	}
-	input_sync(input_dev);
+	if (has_events)
+		input_sync(input_dev);
 	memcpy(keypad->last_key_state, new_state, sizeof(new_state));
 
 	/*
-- 
1.7.10.4
