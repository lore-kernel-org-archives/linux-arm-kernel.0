From: mark.rutland@arm.com (Mark Rutland)
Date: Fri, 17 Feb 2017 12:32:50 +0000
Subject: [BOOTWRAPPER PATCH 2/3] FDT.pm: add helper to get a node's full path
In-Reply-To: <1487334771-25789-1-git-send-email-mark.rutland@arm.com>
References: <1487334771-25789-1-git-send-email-mark.rutland@arm.com>
Message-ID: <1487334771-25789-3-git-send-email-mark.rutland@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This will be useful for subsequent patches where we want to
automatically configure properties for nodes which may have arbitrary
names.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
---
 FDT.pm | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/FDT.pm b/FDT.pm
index f498f09..9adf70b 100755
--- a/FDT.pm
+++ b/FDT.pm
@@ -278,6 +278,25 @@ sub find_by_device_type
 	return @found;
 }
 
+sub get_full_path
+{
+	my $self = shift;
+	my $cur = $self;
+	my @elems = ();
+
+	# root node
+	if (not defined($cur->{parent})) {
+		return '/';
+	}
+
+	while (defined($cur->{parent})) {
+		unshift @elems, $cur->{name};
+		unshift @elems, '/';
+		$cur = $cur->{parent};
+	}
+	return join ('', @elems);
+}
+
 sub get_property
 {
 	my $self = shift;
-- 
1.9.1
