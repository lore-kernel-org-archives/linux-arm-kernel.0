From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 29 May 2015 10:47:20 +0200
Subject: [PATCH] ALSA: fix building with CONFIG_SND_PROC_FS disabled
Message-ID: <4218314.pT4WQLSW4C@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

A recent change to split the procfs support for ALSA turned
out to be incomplete, leading to build errors:

sound/core/seq/seq_info.c:61:12: error: redefinition of 'snd_seq_info_init'
sound/core/seq/seq_device.c: In function 'seq_dev_proc_init':
sound/core/seq/seq_device.c:276:2: error: 'info_entry' undeclared (first use in this function)
sound/core/seq/seq_device.c: In function 'alsa_seq_device_exit':
sound/core/seq/seq_device.c:309:22: error: 'info_entry' undeclared (first use in this function)

This replaces some more instances of CONFIG_PROC_FS with
CONFIG_SND_PROC_FS, as the original patch started. It is
enough to avoid all randconfig regressions I saw on ARM
because of the CONFIG_SND_PROC_FS introduction.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Fixes: cd6a65036f0e ("ALSA: replace CONFIG_PROC_FS with CONFIG_SND_PROC_FS")
---

I assume this was already reported. If not, please apply my patch or
fold it into the original commit.

diff --git a/sound/core/seq/Makefile b/sound/core/seq/Makefile
index b29ffe835205..b65fa5a1943b 100644
--- a/sound/core/seq/Makefile
+++ b/sound/core/seq/Makefile
@@ -7,7 +7,7 @@ snd-seq-device-objs := seq_device.o
 snd-seq-objs := seq.o seq_lock.o seq_clientmgr.o seq_memory.o seq_queue.o \
                 seq_fifo.o seq_prioq.o seq_timer.o \
                 seq_system.o seq_ports.o
-snd-seq-$(CONFIG_PROC_FS) += seq_info.o
+snd-seq-$(CONFIG_SND_PROC_FS) += seq_info.o
 snd-seq-midi-objs := seq_midi.o
 snd-seq-midi-emul-objs := seq_midi_emul.o
 snd-seq-midi-event-objs := seq_midi_event.o
diff --git a/sound/core/seq/seq_device.c b/sound/core/seq/seq_device.c
index 288af56a43cd..c4acf17e9f5e 100644
--- a/sound/core/seq/seq_device.c
+++ b/sound/core/seq/seq_device.c
@@ -272,7 +272,7 @@ EXPORT_SYMBOL_GPL(snd_seq_driver_unregister);
 
 static int __init seq_dev_proc_init(void)
 {
-#ifdef CONFIG_PROC_FS
+#ifdef CONFIG_SND_PROC_FS
 	info_entry = snd_info_create_module_entry(THIS_MODULE, "drivers",
 						  snd_seq_root);
 	if (info_entry == NULL)
@@ -305,7 +305,7 @@ static void __exit alsa_seq_device_exit(void)
 #ifdef CONFIG_MODULES
 	cancel_work_sync(&autoload_work);
 #endif
-#ifdef CONFIG_PROC_FS
+#ifdef CONFIG_SND_PROC_FS
 	snd_info_free_entry(info_entry);
 #endif
 	bus_unregister(&snd_seq_bus_type);
