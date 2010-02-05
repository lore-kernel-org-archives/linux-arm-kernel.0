From: zgao6@marvell.com (Zhangfei Gao)
Date: Sat, 6 Feb 2010 05:38:59 +0800
Subject: [PATCH] i2c: notes of i2c_master_send & i2c_master_recv
Message-ID: <mailman.193.1265349087.2170.linux-arm-kernel@lists.infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

	i2c_master_send & i2c_master_recv not support more than 64bytes
transfer, since msg.len is __u16 type

Signed-off-by: Zhangfei Gao <zgao6@marvell.com>
---
 Documentation/i2c/writing-clients |    3 ++-
 drivers/i2c/i2c-core.c            |    4 ++--
 include/linux/i2c.h               |    1 +
 3 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/Documentation/i2c/writing-clients
b/Documentation/i2c/writing-clients
index 7860aaf..929a3c3 100644
--- a/Documentation/i2c/writing-clients
+++ b/Documentation/i2c/writing-clients
@@ -318,7 +318,8 @@ Plain I2C communication
 These routines read and write some bytes from/to a client. The client
 contains the i2c address, so you do not have to include it. The second
 parameter contains the bytes to read/write, the third the number of bytes
-to read/write (must be less than the length of the buffer.) Returned is
+to read/write (must be less than the length of the buffer, also should be
+less than 64K since msg.len is __u16 type.) Returned is
 the actual number of bytes read/written.

 	int i2c_transfer(struct i2c_adapter *adap, struct i2c_msg *msg,
diff --git a/drivers/i2c/i2c-core.c b/drivers/i2c/i2c-core.c
index 8d80fce..9607dcc 100644
--- a/drivers/i2c/i2c-core.c
+++ b/drivers/i2c/i2c-core.c
@@ -1112,7 +1112,7 @@ EXPORT_SYMBOL(i2c_transfer);
  * i2c_master_send - issue a single I2C message in master transmit mode
  * @client: Handle to slave device
  * @buf: Data that will be written to the slave
- * @count: How many bytes to write
+ * @count: How many bytes to write, should be less than 64K since
msg.len is u16
  *
  * Returns negative errno, or else the number of bytes written.
  */
@@ -1139,7 +1139,7 @@ EXPORT_SYMBOL(i2c_master_send);
  * i2c_master_recv - issue a single I2C message in master receive mode
  * @client: Handle to slave device
  * @buf: Where to store data read from slave
- * @count: How many bytes to read
+ * @count: How many bytes to read, should be less than 64K since msg.len is u16
  *
  * Returns negative errno, or else the number of bytes read.
  */
diff --git a/include/linux/i2c.h b/include/linux/i2c.h
index 57d41b0..b2dea18 100644
--- a/include/linux/i2c.h
+++ b/include/linux/i2c.h
@@ -53,6 +53,7 @@ struct i2c_board_info;
  * on a bus (or read from them). Apart from two basic transfer functions to
  * transmit one message at a time, a more complex version can be used to
  * transmit an arbitrary number of messages without interruption.
+ * Parameter count should be less than 64K since msg.len is __u16
  */
 extern int i2c_master_send(struct i2c_client *client, const char *buf,
 			   int count);
-- 
1.6.0.4

--0015174c14fc691c1d047ed40adb
Content-Type: application/octet-stream; 
	name="0001-i2c-notes-of-i2c_master_send-i2c_master_recv.patch"
Content-Disposition: attachment; 
	filename="0001-i2c-notes-of-i2c_master_send-i2c_master_recv.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_g5ajy6j90

RnJvbSAzMGZiZjFlYmYxZmFjYmEzZDI4MGM4ODdlMmVjZmQwNDk5ZTdiMDRiIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBaaGFuZ2ZlaSBHYW8gPHpnYW82QG1hcnZlbGwuY29tPgpEYXRl
OiBTYXQsIDYgRmViIDIwMTAgMDU6Mzg6NTkgKzA4MDAKU3ViamVjdDogW1BBVENIXSBpMmM6IG5v
dGVzIG9mIGkyY19tYXN0ZXJfc2VuZCAmIGkyY19tYXN0ZXJfcmVjdgoKCWkyY19tYXN0ZXJfc2Vu
ZCAmIGkyY19tYXN0ZXJfcmVjdiBub3Qgc3VwcG9ydCBtb3JlIHRoYW4gNjRieXRlcyB0cmFuc2Zl
ciwgc2luY2UgbXNnLmxlbiBpcyBfX3UxNiB0eXBlCgpTaWduZWQtb2ZmLWJ5OiBaaGFuZ2ZlaSBH
YW8gPHpnYW82QG1hcnZlbGwuY29tPgotLS0KIERvY3VtZW50YXRpb24vaTJjL3dyaXRpbmctY2xp
ZW50cyB8ICAgIDMgKystCiBkcml2ZXJzL2kyYy9pMmMtY29yZS5jICAgICAgICAgICAgfCAgICA0
ICsrLS0KIGluY2x1ZGUvbGludXgvaTJjLmggICAgICAgICAgICAgICB8ICAgIDEgKwogMyBmaWxl
cyBjaGFuZ2VkLCA1IGluc2VydGlvbnMoKyksIDMgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEv
RG9jdW1lbnRhdGlvbi9pMmMvd3JpdGluZy1jbGllbnRzIGIvRG9jdW1lbnRhdGlvbi9pMmMvd3Jp
dGluZy1jbGllbnRzCmluZGV4IDc4NjBhYWYuLjkyOWEzYzMgMTAwNjQ0Ci0tLSBhL0RvY3VtZW50
YXRpb24vaTJjL3dyaXRpbmctY2xpZW50cworKysgYi9Eb2N1bWVudGF0aW9uL2kyYy93cml0aW5n
LWNsaWVudHMKQEAgLTMxOCw3ICszMTgsOCBAQCBQbGFpbiBJMkMgY29tbXVuaWNhdGlvbgogVGhl
c2Ugcm91dGluZXMgcmVhZCBhbmQgd3JpdGUgc29tZSBieXRlcyBmcm9tL3RvIGEgY2xpZW50LiBU
aGUgY2xpZW50CiBjb250YWlucyB0aGUgaTJjIGFkZHJlc3MsIHNvIHlvdSBkbyBub3QgaGF2ZSB0
byBpbmNsdWRlIGl0LiBUaGUgc2Vjb25kCiBwYXJhbWV0ZXIgY29udGFpbnMgdGhlIGJ5dGVzIHRv
IHJlYWQvd3JpdGUsIHRoZSB0aGlyZCB0aGUgbnVtYmVyIG9mIGJ5dGVzCi10byByZWFkL3dyaXRl
IChtdXN0IGJlIGxlc3MgdGhhbiB0aGUgbGVuZ3RoIG9mIHRoZSBidWZmZXIuKSBSZXR1cm5lZCBp
cwordG8gcmVhZC93cml0ZSAobXVzdCBiZSBsZXNzIHRoYW4gdGhlIGxlbmd0aCBvZiB0aGUgYnVm
ZmVyLCBhbHNvIHNob3VsZCBiZQorbGVzcyB0aGFuIDY0SyBzaW5jZSBtc2cubGVuIGlzIF9fdTE2
IHR5cGUuKSBSZXR1cm5lZCBpcwogdGhlIGFjdHVhbCBudW1iZXIgb2YgYnl0ZXMgcmVhZC93cml0
dGVuLgogCiAJaW50IGkyY190cmFuc2ZlcihzdHJ1Y3QgaTJjX2FkYXB0ZXIgKmFkYXAsIHN0cnVj
dCBpMmNfbXNnICptc2csCmRpZmYgLS1naXQgYS9kcml2ZXJzL2kyYy9pMmMtY29yZS5jIGIvZHJp
dmVycy9pMmMvaTJjLWNvcmUuYwppbmRleCA4ZDgwZmNlLi45NjA3ZGNjIDEwMDY0NAotLS0gYS9k
cml2ZXJzL2kyYy9pMmMtY29yZS5jCisrKyBiL2RyaXZlcnMvaTJjL2kyYy1jb3JlLmMKQEAgLTEx
MTIsNyArMTExMiw3IEBAIEVYUE9SVF9TWU1CT0woaTJjX3RyYW5zZmVyKTsKICAqIGkyY19tYXN0
ZXJfc2VuZCAtIGlzc3VlIGEgc2luZ2xlIEkyQyBtZXNzYWdlIGluIG1hc3RlciB0cmFuc21pdCBt
b2RlCiAgKiBAY2xpZW50OiBIYW5kbGUgdG8gc2xhdmUgZGV2aWNlCiAgKiBAYnVmOiBEYXRhIHRo
YXQgd2lsbCBiZSB3cml0dGVuIHRvIHRoZSBzbGF2ZQotICogQGNvdW50OiBIb3cgbWFueSBieXRl
cyB0byB3cml0ZQorICogQGNvdW50OiBIb3cgbWFueSBieXRlcyB0byB3cml0ZSwgc2hvdWxkIGJl
IGxlc3MgdGhhbiA2NEsgc2luY2UgbXNnLmxlbiBpcyB1MTYKICAqCiAgKiBSZXR1cm5zIG5lZ2F0
aXZlIGVycm5vLCBvciBlbHNlIHRoZSBudW1iZXIgb2YgYnl0ZXMgd3JpdHRlbi4KICAqLwpAQCAt
MTEzOSw3ICsxMTM5LDcgQEAgRVhQT1JUX1NZTUJPTChpMmNfbWFzdGVyX3NlbmQpOwogICogaTJj
X21hc3Rlcl9yZWN2IC0gaXNzdWUgYSBzaW5nbGUgSTJDIG1lc3NhZ2UgaW4gbWFzdGVyIHJlY2Vp
dmUgbW9kZQogICogQGNsaWVudDogSGFuZGxlIHRvIHNsYXZlIGRldmljZQogICogQGJ1ZjogV2hl
cmUgdG8gc3RvcmUgZGF0YSByZWFkIGZyb20gc2xhdmUKLSAqIEBjb3VudDogSG93IG1hbnkgYnl0
ZXMgdG8gcmVhZAorICogQGNvdW50OiBIb3cgbWFueSBieXRlcyB0byByZWFkLCBzaG91bGQgYmUg
bGVzcyB0aGFuIDY0SyBzaW5jZSBtc2cubGVuIGlzIHUxNgogICoKICAqIFJldHVybnMgbmVnYXRp
dmUgZXJybm8sIG9yIGVsc2UgdGhlIG51bWJlciBvZiBieXRlcyByZWFkLgogICovCmRpZmYgLS1n
aXQgYS9pbmNsdWRlL2xpbnV4L2kyYy5oIGIvaW5jbHVkZS9saW51eC9pMmMuaAppbmRleCA1N2Q0
MWIwLi5iMmRlYTE4IDEwMDY0NAotLS0gYS9pbmNsdWRlL2xpbnV4L2kyYy5oCisrKyBiL2luY2x1
ZGUvbGludXgvaTJjLmgKQEAgLTUzLDYgKzUzLDcgQEAgc3RydWN0IGkyY19ib2FyZF9pbmZvOwog
ICogb24gYSBidXMgKG9yIHJlYWQgZnJvbSB0aGVtKS4gQXBhcnQgZnJvbSB0d28gYmFzaWMgdHJh
bnNmZXIgZnVuY3Rpb25zIHRvCiAgKiB0cmFuc21pdCBvbmUgbWVzc2FnZSBhdCBhIHRpbWUsIGEg
bW9yZSBjb21wbGV4IHZlcnNpb24gY2FuIGJlIHVzZWQgdG8KICAqIHRyYW5zbWl0IGFuIGFyYml0
cmFyeSBudW1iZXIgb2YgbWVzc2FnZXMgd2l0aG91dCBpbnRlcnJ1cHRpb24uCisgKiBQYXJhbWV0
ZXIgY291bnQgc2hvdWxkIGJlIGxlc3MgdGhhbiA2NEsgc2luY2UgbXNnLmxlbiBpcyBfX3UxNgog
ICovCiBleHRlcm4gaW50IGkyY19tYXN0ZXJfc2VuZChzdHJ1Y3QgaTJjX2NsaWVudCAqY2xpZW50
LCBjb25zdCBjaGFyICpidWYsCiAJCQkgICBpbnQgY291bnQpOwotLSAKMS42LjAuNAoK
--0015174c14fc691c1d047ed40adb--
